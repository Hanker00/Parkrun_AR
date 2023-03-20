import 'package:flutter/material.dart';

class CancelRouteButton extends StatelessWidget {
  const CancelRouteButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        _onPressed();
      },
      // Change ButtonStyle() when the theme is implemented
      style: const ButtonStyle(),
      child: const Text("Cancel navigation"),
    );
  }

  void _onPressed() {
    // 1: Cancel everything related to the navigation itself
    // 2: Redirect back to the starting page
  }
}
