import 'package:flutter/material.dart';
import 'package:parkrun_ar/models/navigation_models/step_nav.dart';

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
            alignment: Alignment.center,
            margin: const EdgeInsets.all(25.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Theme.of(context).primaryColor),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    widget.step.instruction,
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: widget.distance != -1
                      ? Text("${widget.distance.round()} meters left",
                          style: Theme.of(context).textTheme.displayMedium)
                      : const Text("Loading distance..."),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
