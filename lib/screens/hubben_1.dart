import "package:flutter/material.dart";

import 'package:parkrun_ar/models/map_markers/specific_bandel_marker.dart';
import "package:parkrun_ar/widgets/draggable_bottom_sheet.dart";
import "package:parkrun_ar/widgets/top_progress_info.dart";
import "../widgets/map_view.dart";
import "../widgets/stepper_widget_inheritance.dart";

class Hubben1 extends StatelessWidget {
  const Hubben1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //backgroundColor: const Color.fromARGB(255, 33, 32, 32),
        title: const Text('Flutter MapBox'),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          MapView(
            startLatitude: bandel_marks.hubbenMarker[0].startLatitude,
            startLongitude: bandel_marks.hubbenMarker[0].startLongitude,
            mapMarkers: bandel_marks.hubbenMarker,
          ),
          DraggableBottomSheet(children: [
            TopProgressInfo(
              mapMarkers: bandel_marks.hubbenMarker,
              duration: 24,
              distance: 1.9,
            )
          ])
        ],
      ),
    );
  }
}