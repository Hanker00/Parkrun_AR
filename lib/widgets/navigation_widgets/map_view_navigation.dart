import "package:flutter/material.dart";
import "package:flutter_map/flutter_map.dart";
import "package:http/http.dart";
import 'package:parkrun_ar/models/providers/state_notifier_instructions.dart';
import "package:parkrun_ar/models/waypoint_polyline.dart";
import 'package:parkrun_ar/services/mapbox_service.dart';
import "package:provider/provider.dart";
import '../../constants.dart';
import 'package:latlong2/latlong.dart';
import '../../models/map_markers/map_marker.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:async';

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
  bool justEntered = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _mapController = MapController();
    });
    startListening();
  }

  @override
  void dispose() {
    positionStream = null;
    super.dispose();
  }

  void startListening() {
    positionStream = Geolocator.getPositionStream(
        locationSettings: const LocationSettings(
            accuracy: LocationAccuracy.bestForNavigation));
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
            // Making sure the widget is not building before using notifierState
            WidgetsBinding.instance.addPostFrameCallback((_) {
              _mapController.rotate(position.heading);
              distanceToNextStep = calcDistanceFromCurrentPosition(
                  position.latitude,
                  position.longitude,
                  notifierState.currentStep.location[1],
                  notifierState.currentStep.location[0]);
              notifierState.setNextDistance(distanceToNextStep);
              // If the distance to the next step is less than 3 meters, we move to the next step.
              if (distanceToNextStep < 10 && !justEntered) {
                justEntered = true;
              }

              if (distanceToNextStep > 10 && justEntered) {
                justEntered = false;
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
                    isDotted: true,
                    points: widget.polylines
                        .map((i) => LatLng(i.latitude, i.longitude))
                        .toList(),
                    color: Colors.blue,
                    strokeWidth: 5.0,
                  )
                ]),
                MarkerLayer(
                  markers: [
                    // Looping through the map markers and adding them as markers.
                    for (int i = 0; i < widget.mapMarkers.length; i++)
                      Marker(
                        height: 40,
                        width: 40,
                        point: widget.mapMarkers[i].location,
                        builder: (_) {
                          return GestureDetector(
                            onTap: () => null,
                            child: Icon(widget.mapMarkers[i].markerIcon),
                          );
                        },
                      ),
                    Marker(
                        rotate: true,
                        point: LatLng(
                            snapshot.data!.latitude, snapshot.data!.longitude),
                        builder: (_) => const Icon(
                              Icons.arrow_circle_up,
                              color: Colors.red,
                            ))
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
