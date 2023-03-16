class WaypointPolyLine {
  final double latitude;
  final double longitude;

  const WaypointPolyLine({
    required this.latitude,
    required this.longitude,
  });

  factory WaypointPolyLine.fromJson(List<dynamic> json) {
    return WaypointPolyLine(
      longitude: json[0],
      latitude: json[1],
    );
  }
}