import 'package:parkrun_ar/models/step.dart';

class LegNav {
  final num duration;
  final num distance;
  final List<StepNav> steps;

  LegNav({required this.duration, required this.distance, required this.steps});

  factory LegNav.fromJson(Map<String, dynamic> json) {
    final duration = json['duration'] as num;
    final distance = json['distance'] as num;
    final steps = (json['steps'] as List<dynamic>)
        .map((e) => StepNav.fromJson(e as Map<String, dynamic>))
        .toList();

    return LegNav(duration: duration, distance: distance, steps: steps);
  }
}
