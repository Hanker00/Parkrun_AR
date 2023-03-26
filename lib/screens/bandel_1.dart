import "package:flutter/material.dart";
import 'package:parkrun_ar/models/map_markers/specific_bandel_marker.dart';
import "../widgets/map_view.dart";
import "../widgets/stepper_widget_inheritance.dart";

class Bandel1 extends StatelessWidget {
  const Bandel1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //backgroundColor: const Color.fromARGB(255, 33, 32, 32),
        title: const Text('Flutter MapBox'),
      ),
      body: Stack(
        children: [
          Bandel_1_stepper(marker: Bandel_1_marks.mapMarker),
          MapView(
            startLatitude: 57.706650769336136,
            startLongitude: 12.052258936808373,
            mapMarkers: Bandel_1_marks.mapMarker,
          ),
        ],
      ),
    );
  }
}
