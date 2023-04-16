import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:parkrun_ar/models/step.dart';

class NavigationInstruction extends StatefulWidget {
  final StepNav step;
  final num distance;
  const NavigationInstruction(
      {super.key, required this.step, required this.distance});

  @override
  State<NavigationInstruction> createState() => _NavigationInstructionState();
}

class _NavigationInstructionState extends State<NavigationInstruction> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: Colors.white),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(widget.step.instruction),
                ),
                widget.distance != -1
                    ? Text("${widget.distance} meters left")
                    : Text("Loading distance..."),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
