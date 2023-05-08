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

  StateNotifierInstruction(this._index, this._mapMarkers, this.route,
      this._stepIndex, this._currentStep, this._currentLeg, this._legIndex);

  void setState(int index) {
    _index = index;
    print("setState called");
    notifyListeners();
  }

  void increment() {
    _index++;

    notifyListeners();
  }

  void goBack() {
    print("goBack called");
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
    print("goForward called");
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
    print("nextStep called");
    if (_stepIndex >= currentLeg.steps.length - 1) {
      return;
    } else {
      _stepIndex += 1;
      _currentStep = currentLeg.steps[_stepIndex];
      notifyListeners();
      return;
    }
  }

  void update(RouteNav route, int stepIndex, StepNav newStep, LegNav newLeg,
      int legIndex, num newDistance) {
    this.route = route;
    _currentLeg = newLeg;
    _legIndex = legIndex;
    _currentStep = newStep;
    _stepIndex = stepIndex;
    print("update called");
    notifyListeners();
  }
}
