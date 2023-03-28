import 'package:flutter/material.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:parkrun_ar/constants.dart';

import "../models/map_markers/map_marker.dart";
import '../models/shared_prefs.dart';

class MapNavigation extends StatefulWidget {
  final List<MapMarker> mapMarkers;
  const MapNavigation({
    super.key,
    required this.mapMarkers,
  });

  @override
  State<MapNavigation> createState() => _MapNavigationState();
}

class _MapNavigationState extends State<MapNavigation> {
  LatLng latLng = getLatLngFromSharedPrefs();
  late CameraPosition _initialCameraPosition;
  late MapboxMapController controller;

  @override
  void initState() {
    super.initState();
    _initialCameraPosition = CameraPosition(target: latLng, zoom: 15);
  }

  _onMapCreated(MapboxMapController controller) async {
    this.controller = controller;
  }

  _onStyleLoadedCallback() async {
    for (int i = 0; i < widget.mapMarkers.length; i++) {
      await controller.addSymbol(
        SymbolOptions(
          geometry: LatLng(widget.mapMarkers[i].location.latitude,
              widget.mapMarkers[i].location.longitude),
          iconSize: 0.4,
          // Change to the right Icons later
          iconImage: 'assets/icons/map_marker.png',
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Map navigation test'),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.8,
              // Might change style to match map_view map
              child: MapboxMap(
                accessToken: AppConstants.mapBoxAccessToken,
                initialCameraPosition: _initialCameraPosition,
                onMapCreated: _onMapCreated,
                onStyleLoadedCallback: _onStyleLoadedCallback,
                myLocationEnabled: true,
                myLocationTrackingMode: MyLocationTrackingMode.TrackingGPS,
                minMaxZoomPreference: const MinMaxZoomPreference(5, 18),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.animateCamera(
              CameraUpdate.newCameraPosition(_initialCameraPosition));
        },
        child: const Icon(Icons.my_location),
      ),
    );
  }
}
