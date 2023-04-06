import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:parkrun_ar/main.dart';

LatLng getLatLngFromSharedPrefs() {
  return LatLng(sharedPreferences.getDouble('latitude')!,
      sharedPreferences.getDouble('longitude')!);
}
