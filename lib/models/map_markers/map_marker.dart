import "package:flutter/material.dart";
import "package:latlong2/latlong.dart";

/// Abstract class that creates the contract of a Map Marker
abstract class MapMarker {
  final String title;
  final String description;
  final LatLng location;
  final IconData markerIcon;
  final double startLatitude;
  final double startLongitude;

  MapMarker(
      {required this.startLatitude,
      required this.startLongitude,
      required this.title,
      required this.description,
      required this.markerIcon})
      : location = LatLng(startLatitude, startLongitude);
}
