import 'package:flutter/material.dart';
import 'package:parkrun_ar/models/map_markers/map_marker.dart';
import 'package:enhance_stepper/enhance_stepper.dart';
import 'package:provider/provider.dart';

import '../models/stepper_notifier_model.dart';

class AllStepper extends StatefulWidget {
  final List<MapMarker> mapMarkers;

  const AllStepper({super.key, required this.mapMarkers});

  @override
  State<AllStepper> createState() => _AllStepperState();
}

class _AllStepperState extends State<AllStepper> {
  _AllStepperState();

  final StepperType _type = StepperType.vertical;

  @override
  Widget build(BuildContext context) {
    final notifierState = context.watch<StateNotifierModel>();
    return EnhanceStepper(
      stepIconSize: 30,
      type: _type,
      horizontalTitlePosition: HorizontalTitlePosition.bottom,
      horizontalLinePosition: HorizontalLinePosition.top,
      currentStep: notifierState.counter,
      physics: ClampingScrollPhysics(),
      steps: notifierState.mapMarkers
          .map((sign) => EnhanceStep(
              icon: Icon(
                sign.markerIcon,
                color: Colors.blue,
                size: 30,
              ),
              isActive: notifierState.counter ==
                  notifierState.mapMarkers.indexOf(sign),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(sign.title),
                  Checkbox(
                    value: true,
                    onChanged: (bool? value) {
                      notifierState.increment();
                    },
                  ),
                ],
              ),
              subtitle: Text(sign.description),
              content: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: const [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("250m"),
                  ),
                ],
              )))
          .toList(),
      onStepCancel: () {
        notifierState.goBack(-1);
      },
      onStepContinue: () {
        notifierState.goForward(1);
      },
      onStepTapped: (index) {
        notifierState.setState(index);
      },
      controlsBuilder: (BuildContext context, ControlsDetails controls) {
        return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextButton(
                  onPressed: controls.onStepCancel,
                  child: const Text("go back")),
              ElevatedButton(
                  onPressed: controls.onStepContinue,
                  child: const Text("NEXT SIGN"))
            ]);
      },
    );
  }
}
