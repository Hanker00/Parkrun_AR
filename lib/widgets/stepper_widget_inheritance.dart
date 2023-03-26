import 'package:flutter/material.dart';
import 'package:parkrun_ar/models/map_markers/specific_bandel.dart';
import 'package:parkrun_ar/models/stepper_notifier_model.dart';
import 'package:parkrun_ar/widgets/all_stepper.dart';
import 'package:provider/provider.dart';
import '../models/map_markers/map_marker.dart';

class Bandel_1_stepper extends StatefulWidget {
  Bandel_1_stepper({super.key, required this.marker});
  final List<MapMarker> marker;
  @override
  State<Bandel_1_stepper> createState() => _Bandel_1_stepper_state();
}

class _Bandel_1_stepper_state extends State<Bandel_1_stepper> {
  _Bandel_1_stepper_state();
  final int _index = 0;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) =>
            //The notifier requires a markers's field (for bandel 1)
            StateNotifierModel(_index, Bandel_1_marker.bandel_1),
        child: Column(
          children: const <Widget>[
            Expanded(
                child: AllStepper(
              mapMarkers: [],
            ))
          ],
        ));
  }
}
