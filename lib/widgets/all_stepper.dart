import 'package:flutter/material.dart';
import 'package:enhance_stepper/enhance_stepper.dart';
import 'package:parkrun_ar/models/providers/StateNotifierInstructions.dart';
import 'package:provider/provider.dart';

import '../models/stepper_notifier_model.dart';

class AllStepper extends StatefulWidget {
  const AllStepper({super.key});

  @override
  State<AllStepper> createState() => _AllStepperState();
}

class _AllStepperState extends State<AllStepper> {
  _AllStepperState();

  final StepperType _type = StepperType.vertical;

  @override
  Widget build(BuildContext context) {
    final notifierState = context.watch<StateNotifierInstruction>();
    return EnhanceStepper(
      stepIconSize: 30,
      type: _type,
      horizontalTitlePosition: HorizontalTitlePosition.bottom,
      horizontalLinePosition: HorizontalLinePosition.top,
      currentStep: notifierState.counter,
      physics: const ClampingScrollPhysics(),
      steps: notifierState.notifierMarker
          .map((sign) => EnhanceStep(
              icon: Icon(
                sign.markerIcon,
                color: Colors.blue,
                size: 30,
              ),
              isActive: notifierState.counter ==
                  notifierState.notifierMarker.indexOf(sign),
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
              content: const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("250m"),
                  ),
                ],
              )))
          .toList(),
      onStepCancel: () {
        notifierState.goBack();
      },
      onStepContinue: () {
        notifierState.goForward();
      },
      onStepTapped: (index) {
        notifierState.setState(index);
      },
      controlsBuilder: stepperButtons,
    );
  }

  Widget stepperButtons(BuildContext context, ControlsDetails controls) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
      TextButton(
          onPressed: controls.onStepCancel, child: const Text("Go back")),
      ElevatedButton(
          onPressed: controls.onStepContinue, child: const Text("NEXT SIGN"))
    ]);
  }
}
