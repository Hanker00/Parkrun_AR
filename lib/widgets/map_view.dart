import "package:flutter/material.dart";
import "package:flutter_map/flutter_map.dart";
import "package:http/http.dart";
import "package:parkrun_ar/models/waypoint_polyline.dart";
import 'package:parkrun_ar/services/mapbox_service.dart';
import 'package:latlong2/latlong.dart';
import "../models/map_markers/map_marker.dart";
import "markers_info_box.dart";

class MapView extends StatefulWidget {
  final double startLongitude;
  final double startLatitude;
  final List<MapMarker> mapMarkers;
  const MapView({
    super.key,
    required this.startLatitude,
    required this.startLongitude,
    required this.mapMarkers,
  });

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  late MapboxService polyLineService;
  late Future<Response> directionsResponse;
  late Future<List<WaypointPolyLine>> futurePolylines;

  // Runs at once when the widget is first loaded
  @override
  void initState() {
    super.initState();
    polyLineService = MapboxService();
    // fetches our future from service to fetch the polylines.
    directionsResponse = polyLineService.getDirections(widget.mapMarkers);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Builds our widget depending on the result of our future and the polylines
    // returns simple text that an error occured if response is bad
    // returns a loading spinner while response is fetching
    return FutureBuilder<Response>(
        future: directionsResponse,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return FlutterMap(
              options: MapOptions(
                minZoom: 5,
                maxZoom: 18,
                zoom: 14.8,
                center: LatLng(widget.startLatitude, widget.startLongitude),
              ),
              nonRotatedChildren: [
                AttributionWidget.defaultWidget(
                  source: 'OpenStreetMap contributors',
                  onSourceTapped: null,
                ),
              ],
              children: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'com.example.app',
                ),
                PolylineLayer(polylines: [
                  Polyline(
                    points: polyLineService
                        .fetchPolyLines(snapshot.data!)
                        .map((i) => LatLng(i.latitude, i.longitude))
                        .toList(),
                    color: Colors.red,
                    strokeWidth: 5.0,
                  )
                ]),
                MarkerLayer(
                  markers: [
                    for (int i = 0; i < widget.mapMarkers.length; i++)
                      Marker(
                        height: 40,
                        width: 40,
                        point: widget.mapMarkers[i].location,
                        builder: (_) {
                          return GestureDetector(
                            onTap: () => showDialogWithText(
                                widget.mapMarkers[i].description,
                                context,
                                widget.mapMarkers[i].imagePath),
                            child: Icon(widget.mapMarkers[i].markerIcon),
                          );
                        },
                      ),
                  ],
                ),
              ],
            );
          } else if (snapshot.hasError) {
            return Text('In map_view: ${snapshot.error}');
          }
          return const CircularProgressIndicator();
        });
  }
}
