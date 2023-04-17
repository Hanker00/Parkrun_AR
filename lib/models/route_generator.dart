import 'package:flutter/material.dart';
import 'package:parkrun_ar/models/map_markers/specific_bandel_marker.dart';
import 'package:parkrun_ar/screens/bandel_2.dart';
import 'package:parkrun_ar/screens/ParkrunStart.dart';
import 'package:parkrun_ar/screens/bandel_1.dart';
import 'package:parkrun_ar/screens/bandel_3.dart';
import 'package:parkrun_ar/screens/launch_screen.dart';
import 'package:parkrun_ar/screens/navigation_view.dart';
import 'package:parkrun_ar/screens/testing.dart';

class GenerateRoute {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    //Depending on which case the route will generate the page
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const LaunchScreen());
      case '/first':
        return MaterialPageRoute(builder: (_) => const Bandel1());
      case '/second':
        return MaterialPageRoute(builder: (_) => const Bandel2());
      case '/third':
        return MaterialPageRoute(builder: (_) => const Bandel3());
      case '/test':
        return MaterialPageRoute(builder: (_) => const TestWidget());
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
