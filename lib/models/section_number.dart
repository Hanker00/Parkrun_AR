import 'package:parkrun_ar/models/map_markers/map_marker.dart';

class SectionNumber {
  final int sectionNumber;
  final List<MapMarker> mapMarkers;
  final String title;
  final String route;

  SectionNumber({required this.sectionNumber, required this.mapMarkers, required this.title, required this.route});
}