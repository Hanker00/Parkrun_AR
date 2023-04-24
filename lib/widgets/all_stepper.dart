import 'package:flutter/material.dart';
import 'package:enhance_stepper/enhance_stepper.dart';
import 'package:parkrun_ar/models/providers/StateNotifierInstructions.dart';
//import 'package:latlong2/latlong.dart';
//import 'package:parkrun_ar/main.dart';
import 'package:parkrun_ar/models/themeData/theme.dart';
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
    return Column(children: [
      EnhanceStepper(
        stepIconSize: 40,
        type: _type,
        horizontalTitlePosition: HorizontalTitlePosition.bottom,
        horizontalLinePosition: HorizontalLinePosition.top,
        currentStep: notifierState.counter,
        physics: const ClampingScrollPhysics(),
        steps: (notifierState)
            .notifierMarker
            .map((sign) => EnhanceStep(
                  icon: Icon(
                    sign.markerIcon,
                    color: colorSecondary,
                    size: 40,
                  ),
                  title: Flex(
                    direction: Axis.horizontal,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        sign.title,
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                    ],
                  ),
                  content: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [Row(textDirection: TextDirection.rtl,
                      children: [Expanded(
                        child:Text(sign.description),
                      )])],
                  ),
                  isActive: notifierState.counter ==
                      notifierState.notifierMarker.indexOf(sign),
                ))
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
        controlsBuilder: styleStep,
      ),
    ]);
  }

  Widget styleStep(BuildContext context, ControlsDetails controls) {
    return Container();
  }
}
