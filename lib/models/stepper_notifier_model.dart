import 'package:enhance_stepper/enhance_stepper.dart';
import 'package:flutter/material.dart';
import 'package:parkrun_ar/models/map_markers/map_marker.dart';
import 'package:provider/provider.dart';

class StateNotifierModel extends ChangeNotifier {
  final List<MapMarker> mapMarkers;
  int _index = 0;
  int get counter => _index;

  StateNotifierModel(this._index, this.mapMarkers);

  void setState(int index) {
    _index = index;
    print("stepping");
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
    if (index == 1 && index >= mapMarkers.length) {
      notifyListeners();
      return;
    }
  }
}
