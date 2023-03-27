import 'package:flutter/material.dart';
import 'package:parkrun_ar/models/map_markers/specific_bandel_marker.dart';
import 'package:parkrun_ar/models/stepper_notifier_model.dart';
import 'package:parkrun_ar/widgets/all_stepper.dart';
import 'package:provider/provider.dart';
import '../models/map_markers/map_marker.dart';

class Bandel_stepper extends StatefulWidget {
  final List<MapMarker> marker;

  const Bandel_stepper({super.key, required this.marker});
  @override
  // ignore: no_logic_in_create_state
  State<Bandel_stepper> createState() => _Bandel_stepper_state(marker);
}

class _Bandel_stepper_state extends State<Bandel_stepper> {
  final List<MapMarker> _marker;
  _Bandel_stepper_state(this._marker);
  final int _index = 0;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => StateNotifierModel(_index, _marker),
        child: Column(
          children: const <Widget>[Expanded(child: AllStepper())],
        ));
  }
}
