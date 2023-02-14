import "package:flutter/material.dart";
import "package:flutter_map/flutter_map.dart";
import "package:flutter_svg/svg.dart";
import 'package:latlong2/latlong.dart';

import "../constants.dart";
import "../models/map_markers.dart";

class Bandel1 extends StatelessWidget {
  const Bandel1({super.key});

  @override
  Widget build(BuildContext context) {
    final mapMarkers = [
      MapMarker(
        image: 'assets/images/restaurant_1.jpg',
        type: "Right",
        title: 'Alexander The Great Restaurant',
        location: LatLng(57.70743170000001, 12.038226100000008),
      ),
      MapMarker(
        image: 'assets/images/restaurant_2.jpg',
        title: 'Mestizo Mexican Restaurant',
        location: LatLng(57.71056180000001, 12.054330200000013),
        type: 'Right',
      ),
      MapMarker(
        image: 'assets/images/restaurant_3.jpg',
        title: 'The Shed',
        location: LatLng(57.710374800000004, 12.054037699999993),
        type: 'Straight',
      ),
      MapMarker(
          image: 'assets/images/restaurant_4.jpg',
          title: 'Gaucho Tower Bridge',
          location: LatLng(57.706314, 12.040141199999992),
          type: "Straight"),
      MapMarker(
        title: 'Bill\'s Holborn Restaurant',
        location: LatLng(57.710463, 12.055237999999985),
        type: "Right",
        image: '',
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 33, 32, 32),
        title: const Text('Flutter MapBox'),
      ),
      body: Stack(
        children: [
          FlutterMap(
            options: MapOptions(
              minZoom: 5,
              maxZoom: 18,
              zoom: 13,
              center: AppConstants.myLocation,
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
              MarkerLayerOptions(
                markers: [
                  for (int i = 0; i < mapMarkers.length; i++)
                    Marker(
                      height: 30,
                      width: 30,
                      rotate: true,
                      point: mapMarkers[i].location ?? AppConstants.myLocation,
                      builder: (_) {
                        return GestureDetector(
                            onTap: () {}, 
                            child: SvgPicture.asset(
                              "assets/icons/marker.svg"
                            ),
                            );
                      },
                    ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
