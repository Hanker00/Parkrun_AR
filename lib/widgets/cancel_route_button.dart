import 'package:flutter/material.dart';

// Simple button to cancel the navigation
class CancelRouteButton extends StatelessWidget {
  const CancelRouteButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(15.0),
        child: ElevatedButton(
            onPressed: () {
              _onPressed(context);
            },
            style: Theme.of(context).elevatedButtonTheme.style,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Cancel navigation",
                  style: Theme.of(context).textTheme.headlineSmall),
            )));
  }

  void _onPressed(BuildContext context) {
    // Remove all screens until only the homepage exist
    Navigator.of(context).pushNamedAndRemoveUntil(
        Navigator.defaultRouteName, ModalRoute.withName('/'));
  }
}
