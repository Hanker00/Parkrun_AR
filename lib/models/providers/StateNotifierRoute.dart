import 'package:flutter/material.dart';

class StateNotifierRoute extends ChangeNotifier {
  String _route;
  String get notifierRoute => _route;

  StateNotifierRoute(this._route);

  void setRoute(String route) {
    _route = route;
    notifyListeners();
  }
}
