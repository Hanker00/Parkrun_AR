// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

class InfoIconButton extends StatefulWidget {
  final String infoText;
  final Icon icon;

  const InfoIconButton({super.key, required this.infoText, required this.icon});

  @override
  _InfoIconButtonState createState() => _InfoIconButtonState();
}

class _InfoIconButtonState extends State<InfoIconButton> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.info),
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Information'),
              content: Text(widget.infoText),
              actions: [
                TextButton(
                  child: const Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }
}
