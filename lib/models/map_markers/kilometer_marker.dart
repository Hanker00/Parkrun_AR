import 'package:flutter/material.dart';

import 'map_marker.dart';

/// Defines a Kilometer Marker.
///
/// Subclass of [MapMarker] creates a Kilometer Marker that contains an icon with either a one, two, three or 4 sign.
/// Using named constructors different Kilometer Markers are created.
/// [KilometerMarker.one] will create a one sign marker
/// Subsequently Calling [KilometerMarker.anyNumberFrom1to4] will create the number chosen sign marker
class KilometerMarker extends MapMarker {
  int distance;

  /// Creates a Kilometer marker with distance set to 1 and an Icon: [Icons.looks_one]
  KilometerMarker.one(title, String description, double startLatitude,
      double startLongitude, String imagePath)
      : distance = 1,
        super(
            markerIcon: Icons.looks_one,
            title: title,
            description: description,
            startLatitude: startLatitude,
            startLongitude: startLongitude,
            imagePath: '');

  /// Creates a Kilometer marker with distance set to 2 and an Icon: [Icons.looks_two]
  KilometerMarker.two(title, String description, double startLatitude,
      double startLongitude, String imagePath)
      : distance = 2,
        super(
            markerIcon: Icons.looks_two,
            title: title,
            description: description,
            startLatitude: startLatitude,
            startLongitude: startLongitude,
            imagePath: '');

  /// Creates a Kilometer marker with distance set to 3 and an Icon: [Icons.looks_3]
  KilometerMarker.three(title, String description, double startLatitude,
      double startLongitude, String imagePath)
      : distance = 3,
        super(
            markerIcon: Icons.looks_3,
            title: title,
            description: description,
            startLatitude: startLatitude,
            startLongitude: startLongitude,
            imagePath: '');

  /// Creates a Kilometer marker with distance set to 4 and an Icon: [Icons.looks_4]
  KilometerMarker.four(title, String description, double startLatitude,
      double startLongitude, String imagePath)
      : distance = 4,
        super(
            markerIcon: Icons.looks_4,
            title: title,
            description: description,
            startLatitude: startLatitude,
            startLongitude: startLongitude,
            imagePath: '');
}
