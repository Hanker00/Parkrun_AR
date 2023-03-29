import 'package:flutter/material.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

class CenterUserButton extends StatelessWidget {
  const CenterUserButton({
    super.key,
    required this.controller,
    required CameraPosition initialCameraPosition,
  }) : _initialCameraPosition = initialCameraPosition;

  final MapboxMapController controller;
  final CameraPosition _initialCameraPosition;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        controller.animateCamera(
            CameraUpdate.newCameraPosition(_initialCameraPosition));
      },
      child: const Icon(Icons.my_location),
    );
  }
}