import "package:flutter/material.dart";
import "package:flutter_map/flutter_map.dart";
import "../constants.dart";
import 'package:latlong2/latlong.dart';

class MapView extends StatelessWidget {
  final double startLongitude;
  final double startLatitude;
  const MapView({
    super.key, required this.startLatitude, required this.startLongitude,
  });

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
        minZoom: 5,
        maxZoom: 18,
        zoom: 13,
        center: LatLng(startLatitude, startLongitude),
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
      ],
    );
  }
}