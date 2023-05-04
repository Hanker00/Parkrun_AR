import "package:flutter/material.dart";
import 'package:parkrun_ar/models/map_markers/specific_bandel_marker.dart';
import "package:parkrun_ar/widgets/draggable_bottom_sheet.dart";
import "package:parkrun_ar/widgets/top_progress_info.dart";
import "../widgets/back_home_button.dart";
import "../widgets/map_view.dart";

class Bandel2 extends StatelessWidget {
  const Bandel2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Mapbox'),
        leading: const BackHomeButton(),
      ),
      body: Stack(
        children: [
          MapView(
            startLatitude: 57.70336,
            startLongitude: 12.04648,
            mapMarkers: BandelMarks.mapMarkerBandel2,
          ),
          DraggableBottomSheet(children: [
            TopProgressInfo(
              mapMarkers: BandelMarks.mapMarkerBandel2,
              distance: 0.2,
              duration: 4.3,
            )
          ]),
        ],
      ),
    );
  }
}
