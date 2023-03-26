import 'direction_marker.dart';
import 'kilometer_marker.dart';
import 'map_marker.dart';

class Bandel_1_marker {
  static List<MapMarker> get bandel_1 => _bandel_1;

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
}

//To be added: The other banddelar