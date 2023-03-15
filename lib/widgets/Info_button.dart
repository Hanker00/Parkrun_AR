import 'package:flutter/material.dart';

class InfoIconButton extends StatelessWidget {
  final String infoText;
  final Icon icon;
  final Color buttonColor;

  const InfoIconButton({
    Key? key,
    required this.infoText,
    required this.icon,
    required this.buttonColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.info),
      color: buttonColor,
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Information'),
              content: Text(infoText),
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
