import 'package:parkrun_ar/models/leg.dart';

class RouteNav {
  final num duration;
  final num distance;
  final List<LegNav> legs;

  RouteNav(
      {required this.duration, required this.distance, required this.legs});

  factory RouteNav.fromJson(Map<String, dynamic> json) {
    final duration = json['duration'] as num;
    final distance = json['distance'] as num;
    final legs = (json['legs'] as List<dynamic>)
        .map((e) => LegNav.fromJson(e as Map<String, dynamic>))
        .toList();

    return RouteNav(duration: duration, distance: distance, legs: legs);
  }
}
