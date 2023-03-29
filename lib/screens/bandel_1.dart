import "package:flutter/material.dart";

import 'package:parkrun_ar/models/map_markers/specific_bandel_marker.dart';
import "package:parkrun_ar/widgets/draggable_bottom_sheet.dart";
import "package:parkrun_ar/screens/map_navigation.dart";
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
        fit: StackFit.expand,
        children: [
          MapView(
            startLatitude: 57.70715,
            startLongitude: 12.04727,
            mapMarkers: bandel_marks.mapMarker_bandel_1,
          ),
          DraggableBottomSheet(children: [
            BandelStepper(marker: bandel_marks.mapMarker_bandel_1),
          ]),
          // The sizedBox will be removed at a later stage
          SizedBox(
            height: 50,
            width: 314,
            child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => MapNavigation(
                          mapMarkers: bandel_marks.mapMarker_bandel_1),
                    ),
                  );
                },
                child: const Text('To map-navigation')),
          ),
        ],
      ),
    );
  }
}
