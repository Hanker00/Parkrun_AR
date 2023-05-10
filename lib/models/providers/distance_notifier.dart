import 'package:flutter/material.dart';

class DistanceNotifier extends ChangeNotifier {
  num _distanceToNextInstruction;
  num get distanceToNext => _distanceToNextInstruction;

  DistanceNotifier(this._distanceToNextInstruction);

  void setNextDistance(num distance) {
    _distanceToNextInstruction = distance;
    notifyListeners();
  }
}
