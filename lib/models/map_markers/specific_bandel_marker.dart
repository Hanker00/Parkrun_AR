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
    DirectionMarker("Rakt fram",
        "Skylt rakt fram strax efter fyrvägskorsningen", 57.70631, 12.04014),
    DirectionMarker.right(
        "Höger",
        "Skylt vid stenen som leder deltagarna till höger, fortsatt på åttan.",
        57.70743,
        12.03822),
    KilometerMarker.one(
        "1 km",
        "Skylt 1 km under den sista högspänningsledningen.",
        57.70771,
        12.03938),
    KilometerMarker.two(
        "2 km",
        "Skylt 2 km vid klippväggen på vänster sida, strax innan staketet börjar.",
        57.71038,
        12.05371),
    DirectionMarker(
        "Rakt fram", "Skylt rakt fram i höjd med staketet", 57.7103, 12.05403),
    DirectionMarker.right("Höger", "Skylt mot höger, framför brun fast skylt.",
        57.71056, 12.05433),
    DirectionMarker.right(
        "Höger",
        "Skylt höger som leder deltagarna upp på Ormeslättsstigen, bakom Servicehuset.",
        57.71046,
        12.05523),
    DirectionMarker.right(
        "Höger",
        "Skylt höger som leder deltagarna vidare på Ormeslättsstigen, strax efter en liten backe.",
        57.70652,
        12.05289),
  ];

  static final List<MapMarker> _bandel_2 = [
    KilometerMarker.three(
      "3 km",
      "",
      57.7043708,
      12.0472277,
    ),
    DirectionMarker.left(
      "Vänster",
      "Skylt vänster som leder deltagarna upp på 2,5:an - Gröna stigen. Med fördel en skylt innan svängen och en efter.",
      57.7042189,
      12.0447332,
    ),
    DirectionMarker.right("Höger", "Deltagarna ska fortsätta svagt åt höger",
        57.703847, 12.0446193),
    DirectionMarker.right("Höger", "Deltagarna ska fortsätta svagt åt höger",
        57.7034586, 12.0447855)
  ];

  static final List<MapMarker> _bandel_3 = [
    DirectionMarker("Rakt fram", "Vid husknuten", 57.7030581, 12.0370728),
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

  static final List<MapMarker> _hubbenTest = [
    DirectionMarker("Hubben test1", "Fin skylt :) :)", 57.68846, 11.97912),
    DirectionMarker.right(
        "Hubben test2", "Fin skylt :) :)", 57.68961, 11.97833),
    DirectionMarker.left(
        "Hubben test3", "Fin skylt :) :) :)", 57.68963, 11.97708),
    DirectionMarker.uTurn(
        "Hubben test4", "Fin skylt :) :) :) :)", 57.68901, 11.97697),
    DirectionMarker(
        "Hubben test1", "Fin skylt :) :) :) :) :)", 57.68819, 11.97831),
  ];

  static List<MapMarker> get hubbenMarker => _hubbenTest;
}
