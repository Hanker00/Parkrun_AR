import 'package:flutter/material.dart';
import 'package:parkrun_ar/models/map_markers/map_marker.dart';

class StateNotifierModel extends ChangeNotifier {
  final List<MapMarker> _mapMarkers;
  int _index = 0;
  int get counter => _index;
  List<MapMarker> get notifierMarker => _mapMarkers;

  StateNotifierModel(this._index, this._mapMarkers);

  //Specific methods for the stepper and notifies the listeners
  void setState(int index) {
    _index = index;
    notifyListeners();
  }

  void increment() {
    _index++;
    notifyListeners();
  }

  void goBack() {
    if (_index <= 0) {
      return;
    } else {
      _index -= 1;
      notifyListeners();
      return;
    }
  }

  void goForward() {
    if (_index >= _mapMarkers.length - 1) {
      return;
    } else {
      _index += 1;
      notifyListeners();
      return;
    }
  }
}
