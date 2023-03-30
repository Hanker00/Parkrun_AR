import 'package:flutter/material.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:parkrun_ar/constants.dart';
import 'package:parkrun_ar/widgets/Mapbox_map.dart';
import 'package:provider/provider.dart';

import "../models/map_markers/map_marker.dart";
import '../models/map_nav_notifier_model.dart';
import '../models/shared_prefs.dart';
import '../widgets/center_user_button.dart';

class MapNavigation extends StatefulWidget {
  const MapNavigation({super.key});

  @override
  State<MapNavigation> createState() => _MapNavigationState();
}

class _MapNavigationState extends State<MapNavigation> {
  LatLng latLng = getLatLngFromSharedPrefs();
  late CameraPosition _initialCameraPosition;
  late MapboxMapController controller;
  List<MapMarker> mapMarkers = const [];

  @override
  void initState() {
    super.initState();
    _initialCameraPosition = CameraPosition(target: latLng, zoom: 15);
  }
/*
  _onMapCreated(MapboxMapController controller) async {
    this.controller = controller;
  }*/
  /*
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
  }*/

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MapNavNotifierModel(
          mapMarkers, latLng, _initialCameraPosition, controller),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Map navigation test'),
        ),
        body: const NavigationView(),
        floatingActionButton: CenterUserButton(
            controller: controller,
            initialCameraPosition: _initialCameraPosition),
      ),
    );
/*
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
                initialCameraPosition: notifierState.initializeCamera(),
                onMapCreated: notifierState.onMapCreated(controller),
                onStyleLoadedCallback: _onStyleLoadedCallback,
                myLocationEnabled: true,
                myLocationTrackingMode: MyLocationTrackingMode.TrackingGPS,
                minMaxZoomPreference: const MinMaxZoomPreference(5, 18),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: CenterUserButton(
          controller: controller,
          initialCameraPosition: _initialCameraPosition),
    );*/
  }
}
