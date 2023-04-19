import 'direction_marker.dart';
import 'kilometer_marker.dart';
import 'map_marker.dart';

class bandel_marks {
  static List<MapMarker> get mapMarker_bandel_1 => _bandel_1;

  static final List<MapMarker> all_markers = [
    ..._bandel_1 + _bandel_2 + _bandel_3,
  ];

  static final List<MapMarker> _bandel_1 = [
    DirectionMarker("Rakt fram 3", "Sign straight. ", 57.70631, 12.04014,
        "assets/images/section1/sign1.jpg"),
    DirectionMarker.right(
        "Höger 4",
        "Sign by the stone that leads the \nparticipants to the right, continue on number eight.",
        57.70743,
        12.03822,
        "assets/images/section1/sign2.jpg"),
    KilometerMarker.one(
        "1 km id:9",
        "Sign 1 km below the last high-voltage power line.",
        57.70771,
        12.03938,
        "assets/images/section1/1km.jpg"),
    KilometerMarker.two(
        "2 km id:10",
        "Sign 2 km by the cliff wall on the left side, just before the fence begins",
        57.71038,
        12.05371,
        "assets/images/section1/2km.jpg"),
    DirectionMarker(
        "Rakt fram 5",
        "Sign straight ahead at the level of the fence.",
        57.7103,
        12.05403,
        "assets/images/section1/sign3.jpg"),
    DirectionMarker.right(
        "Höger id:6",
        "Sign to the right, in front of a brown fixed sign.",
        57.71056,
        12.05433,
        "assets/images/section1/sign4.jpg"),
    DirectionMarker.right(
        "Höger id:7",
        "Sign to the right that leads the participants up to the Ormeslätts Trail, behind the Service House",
        57.71046,
        12.05523,
        "assets/images/section1/sign5.jpg"),
    DirectionMarker.right(
        "Höger id:8",
        "Sign to the right that leads the participants further on the Ormeslätts Trail, just after a small hill.",
        57.70652,
        12.05289,
        "assets/images/section1/sign6.jpg"),
  ];

  static List<MapMarker> get mapMarker_bandel_2 => _bandel_2;

  static final List<MapMarker> _bandel_2 = [
    KilometerMarker.three(
        "3km", "", 57.7043708, 12.0472277, "assets/images/section2/3km.jpg"),
    DirectionMarker.left(
        "vänster",
        "Skylt vänster som leder deltagarna upp på 2,5:an - Gröna stigen. Med fördel en skylt innan svängen och en efter.",
        57.7042189,
        12.0447332,
        "assets/images/section2/flag3.jpg"),
    DirectionMarker.right("Höger", "Deltagarna ska fortsätta svagt åt höger.",
        57.703847, 12.0446193, "assets/images/section2/flag2.jpg"),
    DirectionMarker.right("Höger", "Deltagarna ska fortsätta svagt åt höger.",
        57.7034586, 12.0447855, "assets/images/section2/flag1.jpg")
  ];

  static List<MapMarker> get mapMarker_bandel_3 => _bandel_3;

  static final List<MapMarker> _bandel_3 = [
    DirectionMarker("Rakt fram 3", "Vid husknuten.", 57.7030581, 12.0370728,
        "assets/images/section3/f1.jpg"),
    DirectionMarker("Rakt fram", "I backen efter korsningen.", 57.6995955,
        12.0370352, "assets/images/section3/f2.jpg"),
    KilometerMarker.four("4 km", "4 km. ", 57.6994292, 12.0395458,
        "assets/images/section3/4km.jpg"),
    DirectionMarker(
        "Rakt fram",
        "skylt rakt fram strax efter korsningen av åttan.",
        57.7003114,
        12.0401587,
        "assets/images/section3/f3.jpg"),
    DirectionMarker.right(
        "Höger",
        "Skylt höger för att deltagarna inte ska ta genvägen.",
        57.7014113,
        12.0432821,
        "assets/images/section3/f4.jpg"),
  ];
}
