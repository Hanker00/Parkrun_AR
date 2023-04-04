import 'direction_marker.dart';
import 'kilometer_marker.dart';
import 'map_marker.dart';

class bandel_marks {
  static List<MapMarker> get mapMarker_bandel_1 => _bandel_1;

  static final List<MapMarker> all_markers = [
    ..._bandel_1 + _bandel_2 + _bandel_3,
  ];

  static final List<MapMarker> _bandel_1 = [
    DirectionMarker(
        "Rakt fram 3",
        "Skylt rakt.\n\n\u{1F4CD} 57.70631, 12.04014",
        57.70631,
        12.04014,
        "assets/images/section1/sign1.jpg"),
    DirectionMarker.right(
        "Höger 4",
        "Skylt vid stenen som leder deltagarna.\ntill höger, fortsatt på åttan.\n\n\u{1F4CD}70631, 12.04014.",
        57.70743,
        12.03822,
        "assets/images/section1/sign2.jpg"),
    KilometerMarker.one(
        "1 km id:9",
        "Skylt 1 km under den sista högspänningsledningen.\n\n\u{1F4CD} 57.70771, 12.03938",
        57.70771,
        12.03938,
        "assets/images/section1/1km.jpg"),
    KilometerMarker.two(
        "2 km id:10",
        "Skylt 2 km vid klippväggen på vänster sida, strax innan staketet börjar.\n\n\u{1F4CD}57.71038, 12.05371",
        57.71038,
        12.05371,
        "assets/images/section1/2km.jpg"),
    DirectionMarker(
        "Rakt fram 5",
        "Skylt rakt fram i höjd med staketet.\n\n\u{1F4CD} 57.7103,12.05403",
        57.7103,
        12.05403,
        "assets/images/section1/sign3.jpg"),
    DirectionMarker.right(
        "Höger id:6",
        "Skylt mot höger, framför brun fast skylt.\n\n\u{1F4CD}57.71056,12.05433",
        57.71056,
        12.05433,
        "assets/images/section1/sign4.jpg"),
    DirectionMarker.right(
        "Höger id:7",
        "Skylt höger som leder deltagarna upp på Ormeslättsstigen, bakom Servicehuset.\n\n\u{1F4CD} 57.71046, 12.05523",
        57.71046,
        12.05523,
        "assets/images/section1/sign5.jpg"),
    DirectionMarker.right(
        "Höger id:8",
        "Skylt höger som leder deltagarna vidare på Ormeslättsstigen, strax efter en liten backe.\n\n\u{1F4CD} 57.70652,12.05289",
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
    DirectionMarker.right("Höger", "Deltagarna ska fortsätta svagt åt höger",
        57.703847, 12.0446193, "assets/images/section2/flag2.jpg"),
    DirectionMarker.right("Höger", "Deltagarna ska fortsätta svagt åt höger",
        57.7034586, 12.0447855, "assets/images/section2/flag1.jpg")
  ];

  static List<MapMarker> get mapMarker_bandel_3 => _bandel_3;

  static final List<MapMarker> _bandel_3 = [
    DirectionMarker(
        "Rakt fram 3", "Vid husknuten", 57.7030581, 12.0370728, 'assets/'),
    DirectionMarker("Rakt fram", "I backen efter korsningen", 57.6995955,
        12.0370352, 'assets/'),
    KilometerMarker.four("4 km", "", 57.6994292, 12.0395458, 'assets'),
    DirectionMarker(
        "Rakt fram",
        "skylt rakt fram strax efter korsningen av åttan",
        57.7003114,
        12.0401587,
        'assets/'),
    DirectionMarker.right(
        "Höger",
        "Skylt höger för att deltagarna inte ska ta genvägen",
        57.7014113,
        12.0432821,
        'assets/'),
  ];
}
