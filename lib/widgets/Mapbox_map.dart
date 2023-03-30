import 'package:flutter/material.dart';
import 'package:parkrun_ar/models/map_nav_notifier_model.dart';
import 'package:provider/provider.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:parkrun_ar/constants.dart';

class NavigationView extends StatefulWidget {
  const NavigationView({super.key});

  @override
  State<NavigationView> createState() => _NavigationViewState();
}

class _NavigationViewState extends State<NavigationView> {
  @override
  Widget build(BuildContext context) {
    final notifierState = context.watch<MapNavNotifierModel>();
    return SafeArea(
        child: Stack(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.8,
          // Might change style to match map_view map
          child: MapboxMap(
            accessToken: AppConstants.mapBoxAccessToken,
            initialCameraPosition: notifierState.initializeCamera(),
            onMapCreated:
                notifierState.onMapCreated(notifierState.notifierController),
            onStyleLoadedCallback: notifierState.onStyleLoadedCallback,
            myLocationEnabled: true,
            myLocationTrackingMode: MyLocationTrackingMode.TrackingGPS,
            minMaxZoomPreference: const MinMaxZoomPreference(5, 18),
          ),
        ),
      ],
    ));
  }
}
