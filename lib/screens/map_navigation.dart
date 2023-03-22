import 'package:flutter/material.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

import '../models/shared_prefs.dart';

class MapNavigation extends StatefulWidget {
  const MapNavigation({Key? key}) : super(key: key);

  @override
  State<MapNavigation> createState() => _MapNavigationState();
}

class _MapNavigationState extends State<MapNavigation> {
  LatLng latLng = getLatLngFromSharedPrefs();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Restaurants Map'),
      ),
      body: SafeArea(
        child: Center(
          child: Text('${latLng.latitude}, ${latLng.longitude}'),
        ),
      ),
    );
  }
}
