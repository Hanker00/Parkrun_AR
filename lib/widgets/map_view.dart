import "dart:async";

import "package:flutter/material.dart";
import "package:flutter_map/flutter_map.dart";
import "package:parkrun_ar/models/waypoint_polyline.dart";
import "package:parkrun_ar/services/polyline_service.dart";
import "../constants.dart";
import 'package:latlong2/latlong.dart';
//import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import "../models/map_markers/map_marker.dart";
import 'package:geolocator/geolocator.dart';

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
  late Position position;
  double long = 0, lat = 0;
  late StreamSubscription<Position> positionStream;
  late PolyLineService polyLineService;
  late Future<List<WaypointPolyLine>> futurePolylines;
  MapController _mapController = MapController();

  // Runs at once when the widget is first loaded
  @override
  void initState() {
    super.initState();
    polyLineService = PolyLineService();
    // fetches our future from service to fetch the polylines.
    futurePolylines = polyLineService.fetchPolyLines(widget.mapMarkers);
    //getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    // Builds our widget depending on the result of our future and the polylines
    // returns simple text that an error occured if response is bad
    // returns a loading spinner while response is fetching
    return FutureBuilder<List<WaypointPolyLine>>(
        future: futurePolylines,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return FlutterMap(
              options: MapOptions(
                minZoom: 5,
                maxZoom: 18,
                zoom: 13,
                center: LatLng(widget.startLatitude, widget.startLongitude),
              ),
              //mapController: _mapController,
              layers: [
                TileLayerOptions(
                  urlTemplate:
                      "https://api.mapbox.com/styles/v1/hanker00/{mapStyleId}/tiles/256/{z}/{x}/{y}@2x?access_token={accessToken}",
                  additionalOptions: {
                    'mapStyleId': AppConstants.mapBoxStyleId,
                    'accessToken': AppConstants.mapBoxAccessToken,
                  },
                ),
                PolylineLayerOptions(
                    //POLYGON ((12.0402593 57.7056307, 12.0412678 57.7071096, 12.0436496 57.7071096, 12.0456666 57.7074764, 12.0484561 57.7085425, 12.0505375 57.7090125, 12.0529193 57.7098493, 12.0536489 57.7092819, 12.0534879 57.7083563, 12.0527208 57.7075151, 12.0518437 57.7066245, 12.0529836 57.7060091, 12.0538016 57.7063386, 12.0550918 57.7076312, 12.0558696 57.7088176, 12.056095 57.7097003, 12.0561165 57.7109841, 12.0536488 57.7112592, 12.0513958 57.7105829, 12.0494861 57.7105829, 12.0480269 57.7107778, 12.0469755 57.710411, 12.046203 57.709322, 12.0430702 57.7084852, 12.039637 57.7083476, 12.0369977 57.7079579, 12.0380491 57.7068459, 12.0381993 57.7057912, 12.0402593 57.7056307))
                    polylines: [
                      Polyline(
                        points: snapshot.data
                            ?.map((i) => LatLng(i.latitude, i.longitude))
                            .toList() as List<LatLng>,
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
                        point: widget.mapMarkers[i].location ??
                            AppConstants.myLocation,
                        builder: (_) {
                          return GestureDetector(
                            onTap: () => print("hej"),
                            child: Icon(widget.mapMarkers[i].markerIcon),
                          );
                        },
                      ),
                  ],
                ),
              ],
            );
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }
          return const CircularProgressIndicator();
        });
  }

  getCurrentLocation() async {
    position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    LocationSettings locationSettings = const LocationSettings(
      accuracy: LocationAccuracy.high, //accuracy of the location data
      distanceFilter: 100, //minimum distance (measured in meters) a
      //device must move horizontally before an update event is generated;
    );

    StreamSubscription<Position> positionStream =
        Geolocator.getPositionStream(locationSettings: locationSettings)
            .listen((Position position) {
      long = position.longitude;
      lat = position.latitude;

      setState(() {
        //_center = LatLng(_locationData.latitude, _locationData.longitude);
        _mapController.move(LatLng(lat, long), 13.0);
      });
    });
  }
}
