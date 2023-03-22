import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

void showDialogWithText(
  text,
  BuildContext context,
) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Text'),
        content: Text(text),
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

Marker createMarker(double lat, double lng, BuildContext context, markertext) {
  return Marker(
    point: LatLng(lat, lng),
    builder: (ctx) => IconButton(
      icon: const Icon(Icons.flag),
      color: Colors.blue,
      iconSize: 40.0,
      tooltip: "prueba",
      onPressed: () {
        showDialogWithText(markertext, context);
      },
    ),
  );
}
