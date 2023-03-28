import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import 'markers_infobox.dart';

class MyMap extends StatefulWidget {
  @override
  _MyMapState createState() => _MyMapState();
}

class _MyMapState extends State<MyMap> {
  List<Marker> _markersbandel1 = [];

  @override
  void initState() {
    super.initState();
    _markersbandel1.add(createMarker(
        57.70631,
        12.04014,
        context,
        'Rkat fram    57.70631,12.04014 \n\nSkylt rakt fram strax efter fyrvägskorsningen ',
        Icons.straight_outlined,
        'assets/icons/marker.png'));
    _markersbandel1.add(createMarker(
        57.70743,
        12.03822,
        context,
        'Höger 4     57.70743,12.03822\n\nSkylt vid stenen som leder deltagarna till höger, fortsatt på åttan ',
        Icons.turn_right_outlined,
        'assets/icons/marker.png'));
    _markersbandel1.add(createMarker(
        57.70771,
        12.03938,
        context,
        '1 km     57.70771,12.03938\n\nSkylt 1 km under den sista högspänningsledningen. ',
        Icons.one_k_outlined,
        'assets/icons/marker.png'));
    _markersbandel1.add(createMarker(
        57.71038,
        12.05371,
        context,
        '2 km     57.71038,12.05371\n\nSkylt 2 km vid klippväggen på vänster sida, strax innan staketet börjar. ',
        Icons.two_k_outlined,
        'assets/images/2km.png'));
    _markersbandel1.add(createMarker(
        57.7103,
        12.05403,
        context,
        'Rakt fram 5     57.7103,12.05403\n\nSkylt rakt fram i höjd med staketet ',
        Icons.straight_outlined,
        'assets/icons/marker.png'));
    _markersbandel1.add(createMarker(
        57.71056,
        12.05433,
        context,
        'Höger     57.71056,12.05433\n\nSkylt mot höger, framför brun fast skylt. ',
        Icons.turn_right_outlined,
        'assets/icons/marker.png'));
    _markersbandel1.add(createMarker(
        57.71046,
        12.05523,
        context,
        'Höger     57.71046,,12.05523\n\nSkylt höger som leder deltagarna upp på Ormeslättsstigen, bakom Servicehuset. ',
        Icons.turn_right_outlined,
        'assets/icons/marker.png'));
    _markersbandel1.add(createMarker(
        57.70652,
        12.05289,
        context,
        'Höger    57.70652,,12.05289\n\nSkylt höger som leder deltagarna vidare på Ormeslättsstigen, strax efter en liten backe. ',
        Icons.turn_right_outlined,
        'assets/icons/marker.png'));
  }

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
        center: LatLng(57.71038, 12.05371),
        zoom: 13.0,
      ),
      layers: [
        TileLayerOptions(
          urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
          subdomains: ['a', 'b', 'c'],
        ),
        MarkerLayerOptions(markers: _markersbandel1),
      ],
    );
  }
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
