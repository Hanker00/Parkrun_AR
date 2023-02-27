import 'package:flutter/material.dart';
import 'package:parkrun_ar/models/MapMarker.dart';

enum DirectionType {
  forward,
  left,
  right,
}
class DirectionMarker extends MapMarker {
  DirectionType type;
  DirectionMarker(this.type, String title, String description, double startLatitude, double startLongitude) 
  : super(markerIcon: Icons.arrow_upward, title:title, description:description, startLatitude: startLatitude, startLongitude: startLongitude);
  
  DirectionMarker.right(this.type, String title, String description, double startLatitude, double startLongitude) 
  : super(markerIcon: Icons.turn_right, title:title, description:description, startLatitude: startLatitude, startLongitude: startLongitude);

  DirectionMarker.left(this.type, String title, String description, double startLatitude, double startLongitude) 
  : super(markerIcon: Icons.turn_left, title:title, description:description, startLatitude: startLatitude, startLongitude: startLongitude);
  }