import "package:flutter/material.dart";
import "package:flutter_map/flutter_map.dart";
import "package:http/http.dart";
import "package:parkrun_ar/models/waypoint_polyline.dart";
import 'package:parkrun_ar/services/MapboxService.dart';
import "../constants.dart";
import 'package:latlong2/latlong.dart';
import "../models/map_markers/map_marker.dart";

class MapViewNavigation extends StatefulWidget {
  final double startLongitude;
  final double startLatitude;
  final List<MapMarker> mapMarkers;
  final List<WaypointPolyLine> polylines;
  const MapViewNavigation(
      {super.key,
      required this.startLongitude,
      required this.startLatitude,
      required this.mapMarkers,
      required this.polylines});

  @override
  State<MapViewNavigation> createState() => _MapViewNavigationState();
}

class _MapViewNavigationState extends State<MapViewNavigation> {
  late MapboxService mapboxService;
  late Future<Response> directionsResponse;
  late Future<List<WaypointPolyLine>> futurePolylines;

  @override
  void initState() {
    super.initState();
    mapboxService = MapboxService();
    // fetches our future from service to fetch the polylines.
    directionsResponse = mapboxService.getDirections(widget.mapMarkers);
  }

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
        minZoom: 5,
        maxZoom: 18,
        zoom: 18,
        center: LatLng(widget.startLatitude, widget.startLongitude),
      ),
      layers: [
        TileLayerOptions(
          urlTemplate:
              "https://api.mapbox.com/styles/v1/hanker00/{mapStyleId}/tiles/256/{z}/{x}/{y}@2x?access_token={accessToken}",
          additionalOptions: {
            'mapStyleId': AppConstants.mapBoxStyleId,
            'accessToken': AppConstants.mapBoxAccessToken,
          },
        ),
        PolylineLayerOptions(polylines: [
          Polyline(
            points: widget.polylines
                .map((i) => LatLng(i.latitude, i.longitude))
                .toList(),
            color: Colors.red,
            strokeWidth: 5.0,
          )
        ]),
        MarkerLayerOptions(
          markers: [
            for (int i = 0; i < widget.mapMarkers.length; i++)
              Marker(
                height: 40,
                width: 40,
                point: widget.mapMarkers[i].location,
                builder: (_) {
                  return GestureDetector(
                    onTap: () => print(""),
                    child: Icon(widget.mapMarkers[i].markerIcon),
                  );
                },
              ),
          ],
        ),
      ],
    );
  }
}
