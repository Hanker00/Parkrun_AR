import "package:flutter/material.dart";
import "package:parkrun_ar/models/map_markers/direction_marker.dart";
import "package:parkrun_ar/models/map_markers/kilometer_marker.dart";
import "package:parkrun_ar/models/map_markers/map_marker.dart";
import 'package:parkrun_ar/models/map_markers/specific_bandel_marker.dart';
import "package:parkrun_ar/widgets/stepper_widget_inheritance.dart";
import "../widgets/map_view.dart";

class Bandel2 extends StatelessWidget {
  const Bandel2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Mapbox'),
      ),
      body: Stack(
        children: [
          BandelStepper(marker: bandel_marks.mapMarker_bandel_2),
          MapView(
            startLatitude: 57.706650769336136,
            startLongitude: 12.052258936808373,
            mapMarkers: bandel_marks.mapMarker_bandel_2,
          ),
        ],
      ),
    );
  }
}
