import "package:flutter/material.dart";
import "package:parkrun_ar/models/map_markers/direction_marker.dart";
import "../models/map_markers/kilometer_marker.dart";
import '../models/map_markers/map_marker.dart';
import "../widgets/map_view.dart";

class Bandel3 extends StatelessWidget {
  static final List<MapMarker> mapMarkers = [
    DirectionMarker("Rakt fram 3", "Vid husknuten",12.0370728, 57.7030581),
    DirectionMarker("Rakt fram", "I backen efter korsningen" ,12.0370352, 57.6995955),
    KilometerMarker.four( "4 km","",12.0395458, 57.6994292),
    DirectionMarker("Rakt fram", "skylt rakt fram strax efter korsningen av åttan",12.0401587, 57.7003114),
    DirectionMarker.right("Höger", "Skylt höger för att deltagarna inte ska ta genvägen", 12.0432821, 57.7014113),
  ];

  const Bandel3({super.key});

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
            mapMarkers: mapMarkers,
          ),
        ],
      ),
    );
  }
}
