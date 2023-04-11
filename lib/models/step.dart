class Step {
  final String instruction;
  final List<double> location;
  final Map<String, dynamic> maneuver;
  final num distance;

  Step(
      {required this.distance,
      required this.instruction,
      required this.location,
      required this.maneuver});

  factory Step.fromJson(Map<String, dynamic> json) {
    final maneuver = json['maneuver'] as Map<String, dynamic>;
    final instruction = maneuver['instruction'] as String;
    final location = (maneuver['location'] as List<dynamic>).cast<double>();
    final distance = json['distance'] as num;

    return Step(
        instruction: instruction,
        location: location,
        maneuver: maneuver,
        distance: distance);
  }
}
