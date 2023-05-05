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
    print("navigationinstruction:" + widget.step.instruction);
    return SafeArea(
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 15.0),
            padding: const EdgeInsets.all(15.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Theme.of(context).primaryColor),
            child: Column(
              children: [
                RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                        style: Theme.of(context).textTheme.displayMedium,
                        children: getNavtext())),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<TextSpan> getNavtext() {
    return widget.step.instruction.startsWith("Your destination")
        ? <TextSpan>[
            TextSpan(
                text: widget.distance != -1
                    ? "${widget.distance.round()} meters to go \n"
                    : "Loading distance... \n"),
            TextSpan(
              text: widget.step.instruction,
            ),
          ]
        : <TextSpan>[
            TextSpan(
              text: "${widget.step.instruction}\n",
            ),
            TextSpan(
                text: widget.distance != -1
                    ? "Next direction will be given in ${widget.distance.round()} meters"
                    : "Loading distance...")
          ];
  }
}
