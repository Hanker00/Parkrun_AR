import 'package:flutter/material.dart';
import 'package:parkrun_ar/screens/Bandel2.dart';
import 'package:parkrun_ar/screens/ParkrunStart.dart';
import 'package:parkrun_ar/screens/bandel_1.dart';

class GenerateRoute {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    //Depending on which case the route will generate the page
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => ParkrunStart());
      case '/first':
        return MaterialPageRoute(builder: (_) => Bandel1());
      case '/second':
        return MaterialPageRoute(builder: (_) => Bandel2());
      default:
        return _errorRoute();
    }
  }

  //Error page will be returned if the argument of route is not string or matches the case argument are incorrect
  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}
