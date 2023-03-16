import "dart:async";

import "package:flutter/material.dart";
import "package:flutter_map/flutter_map.dart";
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
  MapController _mapController = MapController();
  late Position position;
  double long = 0, lat = 0;
  late StreamSubscription<Position> positionStream;

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
        minZoom: 5,
        maxZoom: 18,
        zoom: 13,
        center: LatLng(widget.startLatitude, widget.startLongitude),
      ),
      mapController: _mapController,
      layers: [
        TileLayerOptions(
          urlTemplate:
              "https://api.mapbox.com/styles/v1/hanker00/{mapStyleId}/tiles/256/{z}/{x}/{y}@2x?access_token={accessToken}",
          additionalOptions: {
            'mapStyleId': AppConstants.mapBoxStyleId,
            'accessToken': AppConstants.mapBoxAccessToken,
          },
        ),
        /* LocationMarkerLayerOptions(

        ), */
        MarkerLayerOptions(
          markers: [
            for (int i = 0; i < widget.mapMarkers.length; i++)
              Marker(
                height: 40,
                width: 40,
                point: widget.mapMarkers[i].location ?? AppConstants.myLocation,
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
  }

  @override
  void initState() {
    super.initState();
    getCurrentLocation();
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
