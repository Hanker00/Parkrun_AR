import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

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
                width: 50,
                height: 50,
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

Marker createMarker(double lat, double lng, BuildContext context, markertext,
    IconData iconData, String imagePath) {
  return Marker(
    point: LatLng(lat, lng),
    builder: (ctx) => IconButton(
      icon: Icon(iconData),
      color: Colors.black,
      iconSize: 20.0,
      tooltip: "prueba",
      onPressed: () {
        showDialogWithText(markertext, context, imagePath);
      },
    ),
  );
}
