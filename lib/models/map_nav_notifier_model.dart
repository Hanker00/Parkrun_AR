import 'package:flutter/material.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:parkrun_ar/models/shared_prefs.dart';

import 'map_markers/map_marker.dart';

class MapNavNotifierModel extends ChangeNotifier {
  final List<MapMarker> _mapMarkers;
  List<MapMarker> get notifierMarker => _mapMarkers;

  LatLng latLng = getLatLngFromSharedPrefs();
  LatLng get notifierLatLng => latLng;

  CameraPosition _initialCameraPosition;
  CameraPosition get notifierCameraPosition => _initialCameraPosition;

  MapboxMapController controller;
  MapboxMapController get notifierController => controller;

  MapNavNotifierModel(this._mapMarkers, this.latLng,
      this._initialCameraPosition, this.controller);

  onMapCreated(MapboxMapController controller) async {
    this.controller = controller;
    notifyListeners();
    return controller;
  }

  initializeCamera() {
    notifyListeners();
    return _initialCameraPosition;
  }

  onStyleLoadedCallback() async {
    for (int i = 0; i < _mapMarkers.length; i++) {
      await controller.addSymbol(
        SymbolOptions(
          geometry: LatLng(_mapMarkers[i].location.latitude,
              _mapMarkers[i].location.longitude),
          iconSize: 0.4,
          // Change to the right Icons later
          iconImage: 'assets/icons/map_marker.png',
        ),
      );
    }
    notifyListeners();
  }
}
