import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class NavigationInstruction extends StatefulWidget {
  final String instruction;
  final double distance;
  const NavigationInstruction(
      {super.key, required this.instruction, required this.distance});

  @override
  State<NavigationInstruction> createState() => _NavigationInstructionState();
}

class _NavigationInstructionState extends State<NavigationInstruction> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Text(widget.instruction),
          Text(widget.distance.toString()),
        ],
      ),
    );
  }
}
