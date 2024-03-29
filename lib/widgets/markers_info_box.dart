import 'package:flutter/material.dart';

import 'image_viwe.dart';

void showDialogWithText(
  text,
  BuildContext context,
  String imagePath,
) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Information'),
        content: Row(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyImagePage(imagePath: imagePath),
                  ),
                );
              },
              child: Image.asset(
                imagePath,
                width: 90,
                height: 110,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(child: Text(text)),
          ],
        ),
        backgroundColor: const Color(0xFFFFA300),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('OK'),
          ),
        ],
      );
    },
  );
}
