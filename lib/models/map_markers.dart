import 'package:latlong2/latlong.dart';

class MapMarker {
  final String? image;
  final String? title;
  final LatLng? location;
  final String type;

  MapMarker({
    required this.type,
    required this.image,
    required this.title,
    required this.location,
  });
}
