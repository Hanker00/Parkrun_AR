import "package:flutter/material.dart";
import "package:parkrun_ar/models/map_markers/specific_bandel.dart";
import "../widgets/map_view.dart";

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
          MapView(
            startLatitude: 57.706650769336136,
            startLongitude: 12.052258936808373,
            mapMarkers: Bandel_1_marker.bandel_1,
          ),
        ],
      ),
    );
  }
}
