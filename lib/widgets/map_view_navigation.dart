import "package:flutter/material.dart";
import "package:flutter_map/flutter_map.dart";
import "package:http/http.dart";
import "package:parkrun_ar/models/StateNotifierInstructions.dart";
import "package:parkrun_ar/models/waypoint_polyline.dart";
import 'package:parkrun_ar/services/MapboxService.dart';
import "package:provider/provider.dart";
import "../constants.dart";
import 'package:latlong2/latlong.dart';
import "../models/map_markers/map_marker.dart";
import 'package:geolocator/geolocator.dart';
import 'dart:async';

import "../models/stepper_notifier_model.dart";

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
  late final MapController _mapController;
  final bool liveUpdates = false;
  Stream<Position>? positionStream;
  bool _isMapReady = false;
  num distanceToNextStep = 0;

  @override
  void initState() {
    super.initState();
    mapboxService = MapboxService();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _mapController = MapController();
    });
    startListening();

    // fetches our future from service to fetch the polylines.
    directionsResponse = mapboxService.getDirections(widget.mapMarkers);
  }

  @override
  void dispose() {
    positionStream = null;
    super.dispose();
  }

  void startListening() {
    positionStream = Geolocator.getPositionStream();
  }

  num calcDistanceFromCurrentPosition(double currentLatitude,
      double currentLongitude, double nextLatitude, double nextLongitude) {
    return Geolocator.distanceBetween(
        currentLatitude, currentLongitude, nextLatitude, nextLongitude);
  }

  @override
  Widget build(BuildContext context) {
    final notifierState = context.watch<StateNotifierInstruction>();
    return StreamBuilder<Position>(
        stream: positionStream,
        builder: (BuildContext context, AsyncSnapshot<Position> snapshot) {
          if (snapshot.hasData) {
            final position = snapshot.data!;
            if (_isMapReady && liveUpdates) {
              _mapController.move(
                  LatLng(position.latitude, position.longitude), 18);
            }
            for (int i = 0; i < notifierState.currentLeg.steps.length; i++) {
              print(notifierState.currentLeg.steps[i].location);
            }
            WidgetsBinding.instance!.addPostFrameCallback((_) {
              distanceToNextStep = calcDistanceFromCurrentPosition(
                  position.latitude,
                  position.longitude,
                  notifierState.currentStep.location[1],
                  notifierState.currentStep.location[0]);
              notifierState.setNextDistance(distanceToNextStep);
              print(notifierState.currentStep.location);
              if (distanceToNextStep < 10) {
                notifierState.nextStep();
              }
            });
            return FlutterMap(
              mapController: _mapController,
              options: MapOptions(
                onMapReady: () {
                  _isMapReady = true;
                },
                minZoom: 5,
                maxZoom: 18,
                zoom: 18,
                center: LatLng(position.latitude, position.longitude),
              ),
              children: [
                TileLayer(
                  urlTemplate:
                      "https://api.mapbox.com/styles/v1/hanker00/{mapStyleId}/tiles/256/{z}/{x}/{y}@2x?access_token={accessToken}",
                  additionalOptions: {
                    'mapStyleId': AppConstants.mapBoxStyleId,
                    'accessToken': AppConstants.mapBoxAccessToken,
                  },
                ),
                PolylineLayer(polylines: [
                  Polyline(
                    points: widget.polylines
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
                            onTap: () => print(
                                "${snapshot.data!.latitude}, ${snapshot.data!.longitude}"),
                            child: Icon(widget.mapMarkers[i].markerIcon),
                          );
                        },
                      ),
                    Marker(
                        point: LatLng(
                            snapshot.data!.latitude, snapshot.data!.longitude),
                        builder: (_) => Icon(Icons.my_location))
                  ],
                ),
              ],
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
