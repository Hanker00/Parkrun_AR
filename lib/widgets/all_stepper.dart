import 'package:flutter/material.dart';
import 'package:enhance_stepper/enhance_stepper.dart';
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
    final notifierState = context.watch<StateNotifierModel>();
    return EnhanceStepper(
        stepIconSize: 40,
        type: _type,
        horizontalTitlePosition: HorizontalTitlePosition.bottom,
        horizontalLinePosition: HorizontalLinePosition.top,
        currentStep: notifierState.counter,
        physics: const ClampingScrollPhysics(),
        steps: notifierState.notifierMarker
            .map((sign) => EnhanceStep(
                icon: Icon(
                  sign.markerIcon,
                  color: colorSecondary,
                ),
                isActive: notifierState.counter ==
                    notifierState.notifierMarker.indexOf(sign),
                state: notifierState.counter >= 0
                    ? StepState.complete
                    : StepState.disabled,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(sign.title),
                  ],
                ),
                subtitle: Text(sign.description),
                content:const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children:  [
                    

                    Padding(
                      padding: EdgeInsets.all(8.0),
                      // child: Text("250m"),
                    ),
                  ],
                )
                ))
            .toList(),
        /*onStepCancel: () {
        notifierState.goBack();
      },
    
        onStepContinue: () {
          notifierState.goForward();
        }
        
      onStepTapped: (index) {
        notifierState.setState(index);
      }
    );*/
      
        controlsBuilder: steppercheckbox
        );
  }

  Widget steppercheckbox(BuildContext context, ControlsDetails controls) {
     final notifierState = context.watch<StateNotifierModel>();
    return Row(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[ const Text("sign is DONE"),
      //TextButton( onPressed: controls.onStepCancel, child: const Text("Go back")),
      //ElevatedButton(onPressed: controls.onStepContinue, child: const Text("NEXT SIGN")),
      Checkbox(
        value: false,
        onChanged: (bool? value) {
          notifierState.increment();
          value=true;
        
        },
      )
    ]);
  }
}
