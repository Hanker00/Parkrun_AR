import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SizedBox extends StatelessWidget {
  final double height;
  final double width;
  final Widget child;

  const SizedBox(
      {super.key,
      required this.height,
      required this.width,
      required this.child});

  @override
  Widget build(BuildContext context) {
    return Placeholder();
  }
}
