import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart';
import 'package:parkrun_ar/models/map_markers/map_marker.dart';
import 'package:parkrun_ar/services/mapbox_service.dart';

class RouteDirectionsModel extends ChangeNotifier {
  late Future<Response> _routeDirectionsFuture;
  int numberOfCalls = 0;

  Future<Response> getDirectionsResponse(List<MapMarker> coords, Position pos) {
    if (_routeDirectionsFuture == null && numberOfCalls <= 100) {
      MapboxService mapboxService = MapboxService();
      Future<Response> response = mapboxService.getDirectionsWithCurrentPos(
          coords, pos.latitude, pos.longitude);
      _routeDirectionsFuture = response;
      numberOfCalls++;
    }
    return _routeDirectionsFuture;
  }

  void updateDirections(List<MapMarker> coords, Position pos) async {
    // Call the function in MapBoxState to update the directions

    // Get the updated directions from the MapBoxState object
    if (numberOfCalls <= 100) {
      MapboxService mapboxService = MapboxService();
      Future<Response> response = mapboxService.getDirectionsWithCurrentPos(
          coords, pos.latitude, pos.longitude);
      _routeDirectionsFuture = response;
      numberOfCalls++;
      notifyListeners();
    }
  }
}
