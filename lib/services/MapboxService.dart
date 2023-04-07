import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:parkrun_ar/env/env.dart';
import 'package:parkrun_ar/models/map_markers/map_marker.dart';
import 'package:parkrun_ar/models/waypoint_polyline.dart';

import '../models/step.dart';

/// Service to generate polylines using mapbox api
class MapboxService {
  // Using an async function we make sure we get a response from the api call before doing anything else
  List<WaypointPolyLine> fetchPolyLines(Response response) {
    // we await a response from the api
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      List<WaypointPolyLine> polylines;

      polylines = (json.decode(response.body)['routes'][0]['geometry']
              ['coordinates'] as List)
          .map((i) => WaypointPolyLine.fromJson(i))
          .toList();
      return polylines;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load polylines');
    }
  }

  List<Step> fetchSteps(Response response) {
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      List<Step> steps;

      steps =
          (json.decode(response.body)['routes'][0]['legs'][0]['steps'] as List)
              .map((i) => Step.fromJson(i))
              .toList();
      print(steps[0]);
      return steps;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load steps');
    }
  }

  Future<Response> getDirections(List<MapMarker> coords) {
    String parsedCoords = "";
    // Parse our coords so that we can send them correctly into mapbox directions api in the format of longitude,latitude;
    for (int i = 0; i < coords.length; i++) {
      if (i == coords.length - 1) {
        parsedCoords +=
            "${coords[i].startLongitude},${coords[i].startLatitude}";
      } else {
        parsedCoords +=
            "${coords[i].startLongitude},${coords[i].startLatitude};";
      }
    }
    // we await a response from the api
    return http.get(Uri.parse(
        'https://api.mapbox.com/directions/v5/mapbox/walking/$parsedCoords?alternatives=true&continue_straight=true&geometries=geojson&language=en&overview=full&steps=true&access_token=${Env.mapkey}'));
  }
}
