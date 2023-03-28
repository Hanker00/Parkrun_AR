import "package:flutter/material.dart";
import 'package:parkrun_ar/models/map_markers/specific_bandel_marker.dart';
import "package:parkrun_ar/widgets/stepper_widget_inheritance.dart";
import "../widgets/map_view.dart";

class Bandel2 extends StatelessWidget {
  static final List<MapMarker> mapMarkers = [
    KilometerMarker.three(
      "3km",
      "",
      57.7043708,
      12.0472277,
    ),
    DirectionMarker.left(
      "vänster",
      "Skylt vänster som leder deltagarna upp på 2,5:an - Gröna stigen. Med fördel en skylt innan svängen och en efter.",
      57.7042189,
      12.0447332,
    ),
    DirectionMarker.right("Höger", "Deltagarna ska fortsätta svagt åt höger",
        57.703847, 12.0446193),
    DirectionMarker.right("Höger", "Deltagarna ska fortsätta svagt åt höger",
        57.7034586, 12.0447855)
  ];

  const Bandel2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Mapbox'),
      ),
      body: Stack(
        children: [
          BandelStepper(marker: bandel_marks.mapMarker_bandel_2),
          //TODO: These are not startlat and startlong for bandel 2
          // MapView(
          //   startLatitude: 57.706650769336136,
          //   startLongitude: 12.052258936808373,
          //   mapMarkers: bandel_marks.mapMarker_bandel_2,
          // ),
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
