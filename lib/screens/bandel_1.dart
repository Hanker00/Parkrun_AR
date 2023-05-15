import "package:flutter/material.dart";

import 'package:parkrun_ar/models/map_markers/specific_bandel_marker.dart';
import "package:parkrun_ar/widgets/draggable_bottom_sheet.dart";
import "package:parkrun_ar/widgets/top_progress_info.dart";
import "../widgets/map_view.dart";

class Bandel1 extends StatelessWidget {
  const Bandel1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //backgroundColor: const Color.fromARGB(255, 33, 32, 32),
        title: const Text('Skatås parkrun'),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          MapView(
            startLatitude: 57.70715,
            startLongitude: 12.04727,
            mapMarkers: BandelMarks.mapMarkerBandel1,
          ),
          DraggableBottomSheet(
              intialSize: 0.1,
              maxSize: 0.1,
              minSize: 0.1,
              children: [
                TopProgressInfo(
                  mapMarkers: BandelMarks.mapMarkerBandel1,
                  duration: 24,
                  distance: 1.9,
                )
              ])
        ],
      ),
    );
  }
}
