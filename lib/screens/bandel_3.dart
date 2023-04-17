import "package:flutter/material.dart";
import "package:parkrun_ar/models/map_markers/direction_marker.dart";
import "package:parkrun_ar/models/map_markers/specific_bandel_marker.dart";
import "package:parkrun_ar/widgets/draggable_bottom_sheet.dart";
import "package:parkrun_ar/widgets/stepper_widget_inheritance.dart";
import "package:parkrun_ar/widgets/top_progress_info.dart";
import "../widgets/map_view.dart";

class Bandel3 extends StatelessWidget {
  const Bandel3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('parkrun Skatås'),
      ),
      body: Stack(
        children: [
          MapView(
            startLatitude: 57.69955,
            startLongitude: 12.0403,
            mapMarkers: bandel_marks.mapMarker_bandel_3,
          ),
          DraggableBottomSheet(children: [
            TopProgressInfo(
              mapMarkers: bandel_marks.mapMarker_bandel_3,
              distance: 24.74,
              duration: 1.1,
            )
          ]),
        ],
      ),
    );
  }
}
