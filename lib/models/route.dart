import 'package:parkrun_ar/models/leg.dart';

class Route {
  final num duration;
  final num distance;
  final List<Leg> legs;

  Route({required this.duration, required this.distance, required this.legs});

  factory Route.fromJson(Map<String, dynamic> json) {
    final duration = json['duration'] as num;
    final distance = json['distance'] as num;
    final legs = (json['legs'] as List<dynamic>)
        .map((e) => Leg.fromJson(e as Map<String, dynamic>))
        .toList();

    return Route(duration: duration, distance: distance, legs: legs);
  }
}
