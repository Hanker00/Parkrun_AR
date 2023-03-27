import 'package:flutter/material.dart';
import 'package:parkrun_ar/models/map_markers/map_marker.dart';

class StateNotifierModel extends ChangeNotifier {
  final List<MapMarker> _mapMarkers;
  int _index = 0;
  int get counter => _index;
  List<MapMarker> get notifier_marker => _mapMarkers;

  StateNotifierModel(this._index, this._mapMarkers);

  void setState(int index) {
    _index = index;
    notifyListeners();
  }

  void increment() {
    _index++;
    notifyListeners();
  }

  void goBack(int index) {
    if (index == -1 && index <= 0) {
      notifyListeners();
      return;
    }
  }

  void goForward(int index) {
    if (index == 1 && index >= _mapMarkers.length) {
      notifyListeners();
      return;
    }
  }
}
