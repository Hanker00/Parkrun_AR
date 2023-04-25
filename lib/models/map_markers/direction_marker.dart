import 'package:flutter/material.dart';

import 'map_marker.dart';

enum DirectionType {
  forward,
  left,
  right,
  uTurn,
}

/// Defines a Direction Marker.
///
/// Subclass of [MapMarker] creates a Direction Marker that contains an icon with either forward, right, left or uTurn.
/// Using named constructors different Direction Markers are created.
/// Calling default [DirectionMarker] constructor creates a forward marker, [DirectionMarker.left] will create a left marker
/// [DirectionMarker.right] will create a right marker
/// Subsequently Calling [DirectionMarker.uTurn] will create U-Turn marker
class DirectionMarker extends MapMarker {
  DirectionType type;

  /// Default constructor creates a forward marker with diretion type forward and [Icons.straight_outlined]
  DirectionMarker(String title, String description, double startLatitude,
      double startLongitude, String imagePath)
      : type = DirectionType.forward,
        super(
            markerIcon: Icons.straight_outlined,
            title: title,
            description: description,
            startLatitude: startLatitude,
            startLongitude: startLongitude,
            imagePath: imagePath);

  /// Creates a right marker with direction type right and [Icons.turn_right]
  DirectionMarker.right(String title, String description, double startLatitude,
      double startLongitude, String imagePath)
      : type = DirectionType.right,
        super(
            markerIcon: Icons.turn_right_outlined,
            title: title,
            description: description,
            startLatitude: startLatitude,
            startLongitude: startLongitude,
            imagePath: imagePath);

  /// Creates a left marker with direction type left and [Icons.turn_left]
  DirectionMarker.left(String title, String description, double startLatitude,
      double startLongitude, String imagePath)
      : type = DirectionType.left,
        super(
            markerIcon: Icons.turn_left,
            title: title,
            description: description,
            startLatitude: startLatitude,
            startLongitude: startLongitude,
            imagePath: imagePath);

  /// Creates a U-Turn marker with direction type uTurn and [Icons.u_turn_left]
  DirectionMarker.uTurn(
    String title,
    String description,
    double startLatitude,
    double startLongitude,
  )   : type = DirectionType.uTurn,
        super(
            markerIcon: Icons.u_turn_left,
            title: title,
            description: description,
            startLatitude: startLatitude,
            startLongitude: startLongitude,
            imagePath: '');
}
