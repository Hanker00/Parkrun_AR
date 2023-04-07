import 'package:latlong2/latlong.dart';
import 'package:parkrun_ar/main.dart';

LatLng getLatLngFromSharedPrefs() {
  return LatLng(sharedPreferences.getDouble('latitude')!,
      sharedPreferences.getDouble('longitude')!);
}
