import "package:flutter/material.dart";
import "package:parkrun_ar/constants.dart";
import "package:parkrun_ar/models/map_markers/direction_marker.dart";
import "../models/map_markers/kilometer_marker.dart";
import '../models/map_markers/map_marker.dart';
import "../widgets/map_view.dart";

class Bandel1 extends StatelessWidget {
  static final List<MapMarker> mapMarkers = [
    DirectionMarker("Rakt fram 3", "Skylt rakt fram strax efter fyrvägskorsningen", 57.70631, 12.04014),
    DirectionMarker.right("Höger 4", "Skylt vid stenen som leder deltagarna till höger, fortsatt på åttan.", 57.70743, 12.03822),
    KilometerMarker.one("1 km id:9", "Skylt 1 km under den sista högspänningsledningen.", 57.70771, 12.03938),
    KilometerMarker.two("2 km id:10", "Skylt 2 km vid klippväggen på vänster sida, strax innan staketet börjar.", 57.71038, 12.05371),
    DirectionMarker.right("Höger id:6", "Skylt mot höger, framför brun fast skylt.", 57.71056, 12.05433),
    DirectionMarker("Rakt fram 5", "Skylt rakt fram i höjd med staketet", 57.7103, 12.05403),
    DirectionMarker.right("Höger id:8", "Skylt höger som leder deltagarna vidare på Ormeslättsstigen, strax efter en liten backe.", 57.70652, 12.05289),
    DirectionMarker.right("Höger id:7", "Skylt höger som leder deltagarna upp på Ormeslättsstigen, bakom Servicehuset.", 57.71046, 12.05523)
  ];

  const Bandel1({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 33, 32, 32),
        title: const Text('Flutter MapBox'),
      ),
      body: Stack(
        children: [
          MapView(startLatitude: AppConstants.startLatitude, startLongitude: AppConstants.startLongitude, mapMarkers: mapMarkers,),
        ],
      ),
    );
  }
}


