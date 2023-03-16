import "package:flutter/material.dart";
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
    DirectionMarker("Rakt fram 5", "Skylt rakt fram i höjd med staketet", 57.7103, 12.05403),
    DirectionMarker.right("Höger id:6", "Skylt mot höger, framför brun fast skylt.", 57.71056, 12.05433),
    DirectionMarker.right("Höger id:7", "Skylt höger som leder deltagarna upp på Ormeslättsstigen, bakom Servicehuset.", 57.71046, 12.05523),
    DirectionMarker.right("Höger id:8", "Skylt höger som leder deltagarna vidare på Ormeslättsstigen, strax efter en liten backe.", 57.70652, 12.05289),
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
        fit: StackFit.expand,
        children: [
          MapView(
            startLatitude: 57.706650769336136,
            startLongitude: 12.052258936808373,
            mapMarkers: mapMarkers,
          ),
          DraggableScrollableSheet(
        initialChildSize: .2,
        minChildSize: .1,
        maxChildSize: .9,
        builder: (BuildContext context, ScrollController scrollController) {
          // SingleChildScrollView makes sure the whole sheet scrolls together
          return SingleChildScrollView(
            controller: scrollController,
            // This container adds the coloured bar on top
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              // This column holds the actual content
              child: Column(
                children: [
                  const SizedBox(height: 4),
                  // The row contains the small "scrollable" indicator
                  Row(
                    children: [
                      const Spacer(),
                      Container(
                        height: 8,
                        width: 70,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          color: Colors.amberAccent,
                        ),
                      ),
                      const Spacer(),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(children: [],)
                ],
                // The sheet content goes here!
              ),
            ),
          );
        },
      ),
        ],
      ),
    );
  }
}
