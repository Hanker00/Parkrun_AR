import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

/// Abstrakt klass som skapar kontraktet för en karta marker
abstract class MapMarker {
  final String title;
  final String description;
  final LatLng location;
  final IconData markerIcon;
  final double startLatitude;
  final double startLongitude;
  final String imagePath; // lägg till variabeln för bildsökvägen

  MapMarker({
    required this.startLatitude,
    required this.startLongitude,
    required this.title,
    required this.description,
    required this.markerIcon,
    required this.imagePath, // uppdatera konstruktorn för att ta emot bildsökvägen
  }) : location = LatLng(startLatitude, startLongitude);
}
