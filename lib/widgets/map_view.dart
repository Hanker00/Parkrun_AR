import "package:flutter/material.dart";
import "package:flutter_map/flutter_map.dart";
import "package:parkrun_ar/models/waypoint_polyline.dart";
import "package:parkrun_ar/services/polyline_service.dart";
import "../constants.dart";
import 'package:latlong2/latlong.dart';
import "../models/map_markers/map_marker.dart";
import "markers_infobox.dart";

class MapView extends StatefulWidget {
  final double startLongitude;
  final double startLatitude;
  final List<MapMarker> mapMarkers;
  const MapView({
    super.key,
    required this.startLatitude,
    required this.startLongitude,
    required this.mapMarkers,
  });

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  late PolyLineService polyLineService;
  late Future<List<WaypointPolyLine>> futurePolylines;

  // Runs at once when the widget is first loaded
  @override
  void initState() {
    super.initState();
    polyLineService = PolyLineService();
    // fetches our future from service to fetch the polylines.
    futurePolylines = polyLineService.fetchPolyLines(widget.mapMarkers);
  }

  @override
  Widget build(BuildContext context) {
    // Builds our widget depending on the result of our future and the polylines
    // returns simple text that an error occured if response is bad
    // returns a loading spinner while response is fetching
    return FutureBuilder<List<WaypointPolyLine>>(
        future: futurePolylines,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return FlutterMap(
              options: MapOptions(
                minZoom: 5,
                maxZoom: 18,
                zoom: 13,
                center: LatLng(widget.startLatitude, widget.startLongitude),
              ),
              layers: [
                TileLayerOptions(
                  urlTemplate:
                      "https://api.mapbox.com/styles/v1/hanker00/{mapStyleId}/tiles/256/{z}/{x}/{y}@2x?access_token={accessToken}",
                  additionalOptions: {
                    'mapStyleId': AppConstants.mapBoxStyleId,
                    'accessToken': AppConstants.mapBoxAccessToken,
                  },
                ),
                PolylineLayerOptions(
                    //POLYGON ((12.0402593 57.7056307, 12.0412678 57.7071096, 12.0436496 57.7071096, 12.0456666 57.7074764, 12.0484561 57.7085425, 12.0505375 57.7090125, 12.0529193 57.7098493, 12.0536489 57.7092819, 12.0534879 57.7083563, 12.0527208 57.7075151, 12.0518437 57.7066245, 12.0529836 57.7060091, 12.0538016 57.7063386, 12.0550918 57.7076312, 12.0558696 57.7088176, 12.056095 57.7097003, 12.0561165 57.7109841, 12.0536488 57.7112592, 12.0513958 57.7105829, 12.0494861 57.7105829, 12.0480269 57.7107778, 12.0469755 57.710411, 12.046203 57.709322, 12.0430702 57.7084852, 12.039637 57.7083476, 12.0369977 57.7079579, 12.0380491 57.7068459, 12.0381993 57.7057912, 12.0402593 57.7056307))
                    polylines: [
                      Polyline(
                        points: snapshot.data
                            ?.map((i) => LatLng(i.latitude, i.longitude))
                            .toList() as List<LatLng>,
                        color: Colors.red,
                        strokeWidth: 5.0,
                      )
                    ]),
                MarkerLayerOptions(
                  markers: [
                    /// markers info for bandel1
                    createMarker(
                        57.70631,
                        12.04014,
                        context,
                        'Rkat fram    57.70631,12.04014 \n\nSkylt rakt fram strax efter fyrvägskorsningen ',
                        Icons.straight_outlined,
                        'assets/icons/marker.png'),
                    createMarker(
                        57.70743,
                        12.03822,
                        context,
                        'Höger 4     57.70743,12.03822\n\nSkylt vid stenen som leder deltagarna till höger, fortsatt på åttan ',
                        Icons.turn_right_outlined,
                        'assets/icons/marker.png'),
                    createMarker(
                        57.70771,
                        12.03938,
                        context,
                        '1 km     57.70771,12.03938\n\nSkylt 1 km under den sista högspänningsledningen. ',
                        Icons.one_k_outlined,
                        'assets/icons/marker.png'),
                    createMarker(
                        57.71038,
                        12.05371,
                        context,
                        '2 km     57.71038,12.05371\n\nSkylt 2 km vid klippväggen på vänster sida, strax innan staketet börjar. ',
                        Icons.two_k_outlined,
                        'assets/images/2km.png'),
                    createMarker(
                        57.7103,
                        12.05403,
                        context,
                        'Rakt fram 5     57.7103,12.05403\n\nSkylt rakt fram i höjd med staketet ',
                        Icons.straight_outlined,
                        'assets/icons/marker.png'),
                    createMarker(
                        57.71056,
                        12.05433,
                        context,
                        'Höger     57.71056,12.05433\n\nSkylt mot höger, framför brun fast skylt. ',
                        Icons.turn_right_outlined,
                        'assets/icons/marker.png'),
                    createMarker(
                        57.71046,
                        12.05523,
                        context,
                        'Höger     57.71046,,12.05523\n\nSkylt höger som leder deltagarna upp på Ormeslättsstigen, bakom Servicehuset. ',
                        Icons.turn_right_outlined,
                        'assets/icons/marker.png'),
                    createMarker(
                        57.70652,
                        12.05289,
                        context,
                        'Höger    57.70652,,12.05289\n\nSkylt höger som leder deltagarna vidare på Ormeslättsstigen, strax efter en liten backe. ',
                        Icons.turn_right_outlined,
                        'assets/icons/marker.png'),
                  ],
                ),
              ],
            );
          } else if (snapshot.hasError) {
            return Text('In map_view: ${snapshot.error}');
          }
          return const CircularProgressIndicator();
        });
  }
}
