import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:parkrun_ar/models/step_navigation.dart';

class DistanceCounter {
  final LocationData _location;
  final StepNavigation _step;

  DistanceCounter(this._location, this._step);

  calculatedDistance() {
    var lon1 = _step.stepLongitude;
    var lat1 = _step.stepLatitude;

    var lon2 = _location.longitude;
    var lat2 = _location.latitude;

    var distance = const Distance();

    final double distanceBetween = distance.as(
        LengthUnit.Kilometer, LatLng(lat1, lon1), LatLng(lat2!, lon2!));
    return distanceBetween;
  }
}
