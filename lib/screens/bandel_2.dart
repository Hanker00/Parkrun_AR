import "package:flutter/material.dart";
import "package:parkrun_ar/models/map_markers/direction_marker.dart";
import "package:parkrun_ar/models/map_markers/kilometer_marker.dart";
import "package:parkrun_ar/models/map_markers/map_marker.dart";
import 'package:parkrun_ar/models/map_markers/specific_bandel_marker.dart';
import "package:parkrun_ar/widgets/draggable_bottom_sheet.dart";
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
          MapView(
            startLatitude: 57.70336,
            startLongitude: 12.04648,
            mapMarkers: bandel_marks.mapMarker_bandel_2,
          ),
          DraggableBottomSheet(children: [
            BandelStepper(marker: bandel_marks.mapMarker_bandel_2)
          ]),
        ],
      ),
    );
  }
}
