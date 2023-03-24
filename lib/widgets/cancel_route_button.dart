import 'package:flutter/material.dart';

// Simple button to cancel the navigation
class CancelRouteButton extends StatelessWidget {
  const CancelRouteButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        _onPressed();
      },
      style: Theme.of(context).elevatedButtonTheme.style,
      child: Text("Cancel navigation",
          style: Theme.of(context).textTheme.headlineSmall),
    );
  }

  void _onPressed() {
    // 1: Cancel everything related to the navigation itself
    // 2: Redirect back to the starting page
  }
}