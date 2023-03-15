import "package:flutter/material.dart";
import "package:flutter_map/flutter_map.dart";
import "../constants.dart";
import 'package:latlong2/latlong.dart';
import "../models/map_markers/map_marker.dart";

class MapView extends StatefulWidget {
  final double startLongitude;
  final double startLatitude;
  final List<MapMarker> mapMarkers;
  const MapView({
    super.key, required this.startLatitude, required this.startLongitude, required this.mapMarkers,
  });

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  @override
  Widget build(BuildContext context) {
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
        MarkerLayerOptions(
                markers: [
                  for (int i = 0; i < widget.mapMarkers.length; i++)
                    Marker(
                      height: 40,
                      width: 40,
                      point: widget.mapMarkers[i].location ?? AppConstants.myLocation,
                      builder: (_) {
                        return GestureDetector(
                          onTap: () => print("hej"),
                          child: Icon(widget.mapMarkers[i].markerIcon),
                        );
                      },
                    ),
                ],
              ),

      ],
    );
  }
}