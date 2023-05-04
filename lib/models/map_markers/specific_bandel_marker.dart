import 'direction_marker.dart';
import 'kilometer_marker.dart';
import 'map_marker.dart';

class BandelMarks {
  static List<MapMarker> get mapMarkerBandel1 => _bandel_1;
  static List<MapMarker> get mapMarkerBandel2 => _bandel_2;
  static List<MapMarker> get mapMarkerBandel3 => _bandel_3;

  static final List<MapMarker> allMarkers = [
    ..._bandel_1 + _bandel_2 + _bandel_3,
  ];

  static final List<MapMarker> _bandel_1 = [
    DirectionMarker(
        "Straight forward",
        "The sign straight ahead is just after the intersection with four roads",
        57.70631,
        12.04014,
        "assets/images/section1/sign1.jpg"),
    DirectionMarker.right(
        "Right",
        "The sign by the rock directs the participants to turn right, continue on the eight (route/track).",
        57.70743,
        12.03822,
        "assets/images/section1/sign2.jpg"),
    KilometerMarker.one(
        "1 km",
        "Sign 1 km below the last high-voltage power line.",
        57.70771,
        12.03938,
        "assets/images/section1/1km.jpg"),
    KilometerMarker.two(
        "2 km",
        "Sign 2 km by the cliff wall on the left side, just before the fence begins.",
        57.71038,
        12.05371,
        "assets/images/section1/2km.jpg"),
    DirectionMarker(
        "Straight forward",
        "Sign straight ahead at the level of the fence",
        57.7103,
        12.05403,
        "assets/images/section1/sign4.jpg"),
    DirectionMarker.right(
        "Right",
        "Sign to the right, in front of a brown fixed sign.",
        57.71056,
        12.05433,
        "assets/images/section1/sign4.jpg"),
    DirectionMarker.right(
        "Right",
        "Sign to the right that leads the participants up to the Ormeslätts Trail, behind the Service House.",
        57.71046,
        12.05523,
        "assets/images/section1/sign5.jpg"),
    DirectionMarker.right(
        "Right",
        "Sign to the right that leads the participants further on the Ormeslätts Trail, just after a small hill.",
        57.70652,
        12.05289,
        "assets/images/section1/sign6.jpg"),
  ];

  static final List<MapMarker> _bandel_2 = [
    KilometerMarker.three(
        "3 km", "", 57.7043708, 12.0472277, "assets/images/section2/3km.jpg"),
    DirectionMarker.left(
        "Left",
        "Sign to the left that leads the participants up to the 2.5:an - Green Trail. Ideally, there should be one sign before the turn and one after.",
        57.7042189,
        12.0447332,
        "assets/images/section2/flag3.jpg"),
    DirectionMarker.right(
        "Right",
        "The participants should continue slightly to the right.",
        57.703847,
        12.0446193,
        "assets/images/section2/flag2.jpg"),
    DirectionMarker.right(
        "Right",
        "The participants should continue slightly to the right.",
        57.7034586,
        12.0447855,
        "assets/images/section2/flag1.jpg")
  ];

  static final List<MapMarker> _bandel_3 = [
    DirectionMarker("Straight forward ", "At the corner of the house.",
        57.7030581, 12.0370728, "assets/images/section3/f1.jpg"),
    DirectionMarker("Straight forward", "In the hill after the intersection.",
        57.6995955, 12.0370352, "assets/images/section3/f2.jpg"),
    KilometerMarker.four(
        "4 km", "", 57.6994292, 12.0395458, "assets/images/section3/4km.jpg"),
    DirectionMarker(
        "Straight forward",
        "Sign straight ahead just after the intersection of the number eight trail.",
        57.7003114,
        12.0401587,
        "assets/images/section3/f3.jpg"),
    DirectionMarker.right(
        "Right",
        "Sign to the right so that the participants do not take the shortcut.",
        57.7014113,
        12.0432821,
        "assets/images/section3/f4.jpg"),
  ];

  static final List<MapMarker> _hubbenTest = [
    DirectionMarker("Hubben test1", "Fin skylt :) :)", 57.68846, 11.97912,
        "assets/icons/markers"),
    DirectionMarker.right("Hubben test2", "Fin skylt :) :)", 57.68961, 11.97833,
        "assets/icons/markers"),
    DirectionMarker.left("Hubben test3", "Fin skylt :) :) :)", 57.68963,
        11.97708, "assets/icons/markers"),
    DirectionMarker.uTurn("Hubben test4", "Fin skylt :) :) :) :)", 57.68901,
        11.97697, "assets/icons/markers"),
    DirectionMarker("Hubben test1", "Fin skylt :) :) :) :) :)", 57.68819,
        11.97831, "assets/icons/markers"),
  ];

  static List<MapMarker> get hubbenMarker => _hubbenTest;
}
