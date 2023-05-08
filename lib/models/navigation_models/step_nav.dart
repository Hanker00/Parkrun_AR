class StepNav {
  final String instruction;
  final List<double> location;
  final Map<String, dynamic> maneuver;
  final num distance;

  StepNav(
      {required this.distance,
      required this.instruction,
      required this.location,
      required this.maneuver});

  factory StepNav.fromJson(Map<String, dynamic> json) {
    final maneuver = json['maneuver'] as Map<String, dynamic>;
    final instruction = maneuver['instruction'] as String;
    final location = (maneuver['location'] as List<dynamic>).cast<double>();
    final distance = json['distance'] as num;

    return StepNav(
        instruction: instruction,
        location: location,
        maneuver: maneuver,
        distance: distance);
  }
}
