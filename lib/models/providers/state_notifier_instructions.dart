import 'package:flutter/material.dart';
import 'package:parkrun_ar/models/navigation_models/leg_nav.dart';
import 'package:parkrun_ar/models/map_markers/map_marker.dart';
import 'package:parkrun_ar/models/navigation_models/route_nav.dart';
import 'package:parkrun_ar/models/navigation_models/step_nav.dart';

class StateNotifierInstruction extends ChangeNotifier {
  final List<MapMarker> _mapMarkers;
  int _index = 0;
  int get counter => _index;
  List<MapMarker> get notifierMarker => _mapMarkers;

  RouteNav route;
  LegNav _currentLeg;
  LegNav get currentLeg => _currentLeg;
  int _legIndex = 0;
  int get legIndex => _legIndex;
  StepNav _currentStep;
  StepNav get currentStep => _currentStep;
  int _stepIndex = 0;
  int get stepIndex => _stepIndex;
  num _distanceToNextInstruction;
  num get distanceToNext => _distanceToNextInstruction;

  StateNotifierInstruction(
      this._index,
      this._mapMarkers,
      this.route,
      this._stepIndex,
      this._currentStep,
      this._currentLeg,
      this._legIndex,
      this._distanceToNextInstruction);

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
      _currentLeg = route.legs[_index];
      _legIndex = _index;
      _currentStep = _currentLeg.steps[0];
      _stepIndex = 0;
      notifyListeners();
      return;
    }
  }

  void goForward() {
    if (_index >= _mapMarkers.length - 1) {
      return;
    } else {
      _index += 1;
      _currentLeg = route.legs[_index];
      _legIndex = _index;
      _currentStep = _currentLeg.steps[0];
      _stepIndex = 0;
      notifyListeners();
      return;
    }
  }

  void nextStep() {
    if (_stepIndex >= currentLeg.steps.length - 1) {
      return;
    } else {
      _stepIndex += 1;
      _currentStep = currentLeg.steps[_stepIndex];
      notifyListeners();
      return;
    }
  }

  void setNextDistance(num distance) {
    _distanceToNextInstruction = distance;
    notifyListeners();
  }
}
