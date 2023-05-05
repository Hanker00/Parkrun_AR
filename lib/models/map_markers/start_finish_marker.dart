import 'package:flutter/material.dart';
import 'map_marker.dart';

/// Defines a Start and finish Marker.
///
/// Subclass of [MapMarker] creates a Start and Finish Marker that contains an icon with a checkered flag.
class StartFinishMarker extends MapMarker {
  /// Creates a Start and Finish Marker that contains an icon with a checkered flag.
  StartFinishMarker(
      title, String description, double startLatitude, double startLongitude)
      : super(
            markerIcon: Icons.sports_score,
            title: title,
            description: description,
            startLatitude: startLatitude,
            startLongitude: startLongitude,
            imagePath: '');
}
