import 'package:flutter/material.dart';

class StateNotifierRoute extends ChangeNotifier {
  String route;
  String get notifierRoute => route;

  StateNotifierRoute(this.route);

  void setRoute(String route) {
    this.route = route;
    notifyListeners();
  }
}
