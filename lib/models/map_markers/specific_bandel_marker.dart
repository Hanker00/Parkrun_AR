import 'direction_marker.dart';
import 'kilometer_marker.dart';
import 'map_marker.dart';

class bandel_marks {
  static List<MapMarker> get mapMarker_bandel_1 => _bandel_1;

  static final List<MapMarker> all_markers = [
    ..._bandel_1 + _bandel_2 + _bandel_3,
  ];

  static final List<MapMarker> _bandel_1 = [
    DirectionMarker("Rakt fram 3",
        "Skylt rakt fram strax efter fyrvägskorsningen", 57.70631, 12.04014),
    DirectionMarker.right(
        "Höger 4",
        "Skylt vid stenen som leder deltagarna till höger, fortsatt på åttan.",
        57.70743,
        12.03822),
    KilometerMarker.one(
        "1 km id:9",
        "Skylt 1 km under den sista högspänningsledningen.",
        57.70771,
        12.03938),
    KilometerMarker.two(
        "2 km id:10",
        "Skylt 2 km vid klippväggen på vänster sida, strax innan staketet börjar.",
        57.71038,
        12.05371),
    DirectionMarker("Rakt fram 5", "Skylt rakt fram i höjd med staketet",
        57.7103, 12.05403),
    DirectionMarker.right("Höger id:6",
        "Skylt mot höger, framför brun fast skylt.", 57.71056, 12.05433),
    DirectionMarker.right(
        "Höger id:7",
        "Skylt höger som leder deltagarna upp på Ormeslättsstigen, bakom Servicehuset.",
        57.71046,
        12.05523),
    DirectionMarker.right(
        "Höger id:8",
        "Skylt höger som leder deltagarna vidare på Ormeslättsstigen, strax efter en liten backe.",
        57.70652,
        12.05289),
  ];

  static List<MapMarker> get mapMarker_bandel_2 => _bandel_2;

  static final List<MapMarker> _bandel_2 = [
    KilometerMarker.three(
      "3km",
      "",
      57.7043708,
      12.0472277,
    ),
    DirectionMarker.left(
      "vänster",
      "Skylt vänster som leder deltagarna upp på 2,5:an - Gröna stigen. Med fördel en skylt innan svängen och en efter.",
      57.7042189,
      12.0447332,
    ),
    DirectionMarker.right("Höger", "Deltagarna ska fortsätta svagt åt höger",
        57.703847, 12.0446193),
    DirectionMarker.right("Höger", "Deltagarna ska fortsätta svagt åt höger",
        57.7034586, 12.0447855)
  ];

  static List<MapMarker> get mapMarker_bandel_3 => _bandel_3;

  static final List<MapMarker> _bandel_3 = [
    DirectionMarker("Rakt fram 3", "Vid husknuten", 57.7030581, 12.0370728),
    DirectionMarker(
        "Rakt fram", "I backen efter korsningen", 57.6995955, 12.0370352),
    KilometerMarker.four("4 km", "", 57.6994292, 12.0395458),
    DirectionMarker(
      "Rakt fram",
      "skylt rakt fram strax efter korsningen av åttan",
      57.7003114,
      12.0401587,
    ),
    DirectionMarker.right(
      "Höger",
      "Skylt höger för att deltagarna inte ska ta genvägen",
      57.7014113,
      12.0432821,
    ),
  ];
}
