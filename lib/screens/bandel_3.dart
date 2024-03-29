import "package:flutter/material.dart";
import "package:parkrun_ar/models/map_markers/specific_bandel_marker.dart";
import "package:parkrun_ar/widgets/draggable_bottom_sheet.dart";
import "package:parkrun_ar/widgets/top_progress_info.dart";
import "../widgets/map_view.dart";

class Bandel3 extends StatelessWidget {
  const Bandel3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Skatås parkrun'),
      ),
      body: Stack(
        children: [
          MapView(
            startLatitude: 57.69955,
            startLongitude: 12.0403,
            mapMarkers: BandelMarks.mapMarkerBandel3,
          ),
          DraggableBottomSheet(
              intialSize: 0.1,
              maxSize: 1,
              minSize: 0.1,
              children: [
                TopProgressInfo(
                  mapMarkers: BandelMarks.mapMarkerBandel3,
                  distance: 1.1,
                  duration: 24.74,
                )
              ]),
        ],
      ),
    );
  }
}
