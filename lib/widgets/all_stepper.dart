import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:parkrun_ar/models/map_markers/map_marker.dart';
import 'package:enhance_stepper/enhance_stepper.dart';

class AllStepper extends StatefulWidget {
  final List<MapMarker> mapMarkers;
  const AllStepper({super.key, required this.mapMarkers});

  @override
  State<AllStepper> createState() => _AllStepperState();
}

class _AllStepperState extends State<AllStepper> {
  int _index = 0;

  final StepperType _type = StepperType.vertical;

  _AllStepperState();

  void go(int index) {
    if (index == -1 && _index <= 0 ) {
      print("it's first Step!");
      return;
    }

    if (index == 1 && _index >= widget.mapMarkers.length - 1) {
      print("it's last Step!");
      return;
    }

    setState(() {
      _index += index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return EnhanceStepper(
        stepIconSize: 30,
        type: _type,
        horizontalTitlePosition: HorizontalTitlePosition.bottom,
        horizontalLinePosition: HorizontalLinePosition.top,
        currentStep: _index,
        physics: ClampingScrollPhysics(),
        steps: widget.mapMarkers.map((sign) => EnhanceStep(
          icon: Icon(sign.markerIcon, color: Colors.blue, size: 30,),
          isActive: _index == widget.mapMarkers.indexOf(sign),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(sign.title),
              Checkbox(value: true,
      onChanged: (bool? value) {
        setState(() {
          value = false;
        });
      },),
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
          )
        )).toList(),
        onStepCancel: () {
          go(-1);
        },
        onStepContinue: () {
          go(1);
        },
        onStepTapped: (index) {
          print(index);
          setState(() {
            _index = index;
          });
        },
        controlsBuilder: (BuildContext context, ControlsDetails controls) {
                  return Row(
                    children: <Widget>[
                    ],
                  );
                },
    );
  }
}
