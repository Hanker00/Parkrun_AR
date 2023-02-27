import "package:flutter/material.dart";
import "package:flutter_svg/svg.dart";
import "package:latlong2/latlong.dart";


enum MarkerType {
  right,
  left,
  startFinish,
  uTurn,
  forward,
  kmMarker,
}

class MapMarker {
  final String title;
  final String description;
  final LatLng location;
  IconData markerIcon;

  MapMarker({required this.title, required this.description, required double startLatitude, required double startLongitude, required this.markerIcon}) : location = LatLng(startLatitude
  , startLongitude);
}