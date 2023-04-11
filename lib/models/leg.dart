import 'package:parkrun_ar/models/step.dart';

class Leg {
  final num duration;
  final num distance;
  final List<Step> steps;

  Leg({required this.duration, required this.distance, required this.steps});

  factory Leg.fromJson(Map<String, dynamic> json) {
    final duration = json['duration'] as num;
    final distance = json['distance'] as num;
    final steps = (json['steps'] as List<dynamic>)
        .map((e) => Step.fromJson(e as Map<String, dynamic>))
        .toList();

    return Leg(duration: duration, distance: distance, steps: steps);
  }
}
