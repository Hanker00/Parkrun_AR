import 'package:flutter/material.dart';
import 'package:parkrun_ar/models/map_markers/specific_bandel_marker.dart';
import 'package:parkrun_ar/models/stepper_notifier_model.dart';
import 'package:parkrun_ar/widgets/all_stepper.dart';
import 'package:provider/provider.dart';
import '../models/map_markers/map_marker.dart';
import 'current_step.dart';

class BandelStepper extends StatefulWidget {
  final List<MapMarker> marker;

  const BandelStepper({super.key, required this.marker});
  @override
  State<BandelStepper> createState() => _BandelStepperState();
}

class _BandelStepperState extends State<BandelStepper> {
  _BandelStepperState();
  final int _index = 0;

//Notifier provider - hierarchy so that the AllStepper() makes changes according to the model
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => StateNotifierModel(_index, widget.marker),
        child: Column(
          children: const <Widget>[
            CurrentStep(),
            Divider(
              height: 10,
              thickness: 2,
            ),
            AllStepper()
          ],
        ));
  }
}
