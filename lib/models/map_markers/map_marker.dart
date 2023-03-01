import "package:flutter/material.dart";
import "package:latlong2/latlong.dart";

/// Abstract class that creates the contract of a Map Marker
abstract class MapMarker {
  final String title;
  final String description;
  final LatLng location;
  IconData markerIcon;

  MapMarker({required this.title, required this.description, required double startLatitude, required double startLongitude, required this.markerIcon}) : location = LatLng(startLatitude
  , startLongitude);
}