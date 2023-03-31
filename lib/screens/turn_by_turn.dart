import 'package:flutter/material.dart';
import 'package:flutter_mapbox_navigation/flutter_mapbox_navigation.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:parkrun_ar/models/shared_prefs.dart';

import '../models/map_markers/map_marker.dart';

class TurnByTurn extends StatefulWidget {
  final List<MapMarker> mapMarkers;
  const TurnByTurn({
    super.key,
    required this.mapMarkers,
  });

  @override
  State<TurnByTurn> createState() => _TurnByTurnState();
}

class _TurnByTurnState extends State<TurnByTurn> {
  // Waypoints to mark trip start and end
  LatLng source = getLatLngFromSharedPrefs();
  late WayPoint sourceWaypoint;
  var wayPoints = <WayPoint>[];

  // Config variables for Mapbox Navigation
  late MapBoxNavigation directions;
  late MapBoxOptions _options;
  late double? distanceRemaining, durationRemaining;
  late MapBoxNavigationViewController _controller;
  bool isMultipleStop = false;
  String instruction = "";
  bool arrived = false;
  bool routeBuilt = false;
  bool isNavigating = false;

  @override
  void initState() {
    super.initState();
    initialize();
  }

  Future<void> initialize() async {
    if (!mounted) return;

    // Setup directions and options
    MapBoxNavigation.instance.registerRouteEventListener(_onRouteEvent);
    _options = MapBoxOptions(
        zoom: 18.0,
        voiceInstructionsEnabled: true,
        bannerInstructionsEnabled: true,
        mode: MapBoxNavigationMode.walking,
        isOptimized: true,
        units: VoiceUnits.metric,
        simulateRoute: true,
        language: "en");

    /*
    MapBoxNavigation.instance.setDefaultOptions(MapBoxOptions(
                     initialLatitude: 36.1175275,
                     initialLongitude: -115.1839524,
                     zoom: 13.0,
                     tilt: 0.0,
                     bearing: 0.0,
                     enableRefresh: false,
                     alternatives: true,
                     voiceInstructionsEnabled: true,
                     bannerInstructionsEnabled: true,
                     allowsUTurnAtWayPoints: true,
                     mode: MapBoxNavigationMode.drivingWithTraffic,
                     mapStyleUrlDay: "https://url_to_day_style",
                     mapStyleUrlNight: "https://url_to_night_style",
                     units: VoiceUnits.imperial,
                     simulateRoute: true,
                     language: "en"))
    */

    // Configure waypoints
    sourceWaypoint = WayPoint(
        name: "Source", latitude: source.latitude, longitude: source.longitude);
    wayPoints.add(sourceWaypoint);
    for (int i = 0; i < widget.mapMarkers.length; i++) {
      isMultipleStop = true;
      WayPoint currentMarkerWaypoint = WayPoint(
          name: widget.mapMarkers[i].title,
          latitude: widget.mapMarkers[i].location.latitude,
          longitude: widget.mapMarkers[i].location.longitude);
      wayPoints.add(currentMarkerWaypoint);
    }

    // Start the trip
    //await directions.startNavigation(wayPoints: wayPoints, options: _options);
  }

  Future<void> _onRouteEvent(e) async {
    distanceRemaining = await directions.getDistanceRemaining();
    durationRemaining = await directions.getDurationRemaining();

    switch (e.eventType) {
      case MapBoxEvent.progress_change:
        var progressEvent = e.data as RouteProgressEvent;
        arrived = progressEvent.arrived!;
        if (progressEvent.currentStepInstruction != null) {
          instruction = progressEvent.currentStepInstruction!;
        }
        break;
      case MapBoxEvent.route_building:
      case MapBoxEvent.route_built:
        routeBuilt = true;
        break;
      case MapBoxEvent.route_build_failed:
        routeBuilt = false;
        break;
      case MapBoxEvent.navigation_running:
        isNavigating = true;
        break;
      case MapBoxEvent.on_arrival:
        arrived = true;
        if (!isMultipleStop) {
          await Future.delayed(const Duration(seconds: 3));
          await _controller.finishNavigation();
        } else {}
        break;
      case MapBoxEvent.navigation_finished:
      case MapBoxEvent.navigation_cancelled:
        routeBuilt = false;
        isNavigating = false;
        break;
      default:
        break;
    }
    //refresh UI
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey,
      child: MapBoxNavigationView(
          options: _options,
          onRouteEvent: _onRouteEvent,
          onCreated: (MapBoxNavigationViewController controller) async {
            _controller = controller;
            controller.initialize();
            _controller.buildRoute(wayPoints: wayPoints);
            _controller.startNavigation();
          }),
    );
  }
}
