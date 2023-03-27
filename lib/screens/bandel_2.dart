import "package:flutter/material.dart";
import "package:parkrun_ar/models/map_markers/direction_marker.dart";
import "../models/map_markers/kilometer_marker.dart";
import '../models/map_markers/map_marker.dart';
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
        title: const Text('parkrun Skatås'),
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
