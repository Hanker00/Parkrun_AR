class StepNavigation {
  final String instruction;
  final List<double> location;
  final Map<String, dynamic> maneuver;
  final double latitude;
  final double longitude;

  double get stepLatitude => latitude;
  double get stepLongitude => longitude;

  StepNavigation(
      {required this.instruction,
      required this.location,
      required this.maneuver,
      required this.latitude,
      required this.longitude});

  factory StepNavigation.fromJson(Map<String, dynamic> json) {
    final maneuver = json['maneuver'] as Map<String, dynamic>;
    final instruction = maneuver['instruction'] as String;
    final location = (maneuver['location'] as List<dynamic>).cast<double>();
    final latitude = json['latitude'] as double;
    final longitude = json['longitude'] as double;

    return StepNavigation(
        instruction: instruction,
        location: location,
        maneuver: maneuver,
        latitude: latitude,
        longitude: longitude);
  }
}
