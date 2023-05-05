import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart';
import 'package:latlong2/latlong.dart';
import 'package:parkrun_ar/models/map_markers/map_marker.dart';
import 'package:parkrun_ar/services/mapbox_service.dart';

class RouteDirectionsModel extends ChangeNotifier {
  Future<Response>? _routeDirectionsFuture = null;
  int numberOfCalls = 0;

  Future<Response>? getDirectionsResponse(List<MapMarker> coords, LatLng pos) {
    if (_routeDirectionsFuture == null && numberOfCalls <= 20) {
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
    if (numberOfCalls <= 20) {
      MapboxService mapboxService = MapboxService();
      print("just made a call");
      Future<Response> response = mapboxService.getDirectionsWithCurrentPos(
          coords, pos.latitude, pos.longitude);
      _routeDirectionsFuture = response;
      numberOfCalls++;
      notifyListeners();
    }
  }
}
