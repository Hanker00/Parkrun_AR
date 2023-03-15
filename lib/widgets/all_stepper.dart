import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:parkrun_ar/models/map_markers/map_marker.dart';

class AllStepper extends StatefulWidget {
  final List<MapMarker> mapMarkers;
  const AllStepper({super.key, required this.mapMarkers});

  @override
  State<AllStepper> createState() => _AllStepperState();
}

class _AllStepperState extends State<AllStepper> {
  int _index = 0;

  _AllStepperState();

  @override
  Widget build(BuildContext context) {
    return Stepper(
        currentStep: _index,
        onStepCancel: () {
          if (_index > 0) {
            setState(() {
              _index -= 1;
            });
          }
        },
        onStepContinue: () {
          if (_index < widget.mapMarkers.length) {
            setState(() {
              _index += 1;
            });
          } else {
            setState(() {
              _index += 0;
            });
          }
        },
        onStepTapped: (int index) {
          setState(() {
            _index = index;
          });
        },
        steps: widget.mapMarkers
            .map(
              (sign) => Step(
                title: SizedBox(
                  width: 50,
                  child: ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Text("hej"),
                    title: Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Icon(
                        sign.markerIcon,
                        size: 18,
                      ),
                    ),
                  ),
                ),
                content: SizedBox(
                  width: 0.0,
                  height: 0.0,
                ),
              ),
            )
            .toList());
  }
}
