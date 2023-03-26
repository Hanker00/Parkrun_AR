import "package:flutter/material.dart";
import "package:parkrun_ar/models/map_markers/direction_marker.dart";
import "package:parkrun_ar/models/map_markers/specific_bandel_marker.dart";
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
            startLatitude: 57.706650769336136,
            startLongitude: 12.052258936808373,
            mapMarkers: Bandel_3_marks.mapMarker,
          ),
        ],
      ),
    );
  }
}
