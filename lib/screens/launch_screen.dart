import 'package:flutter/material.dart';
import 'package:parkrun_ar/models/map_markers/specific_bandel_marker.dart';
import 'package:parkrun_ar/models/providers/StateNotifierRoute.dart';
import 'package:parkrun_ar/models/section_number.dart';
import 'package:parkrun_ar/widgets/map_view.dart';
import 'package:parkrun_ar/widgets/select_section_modal.dart';
import 'package:provider/provider.dart';
import 'package:location/location.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:parkrun_ar/main.dart';

class LaunchScreen extends StatefulWidget {
  const LaunchScreen({super.key});

  @override
  State<LaunchScreen> createState() => _LaunchScreenState();
}

class _LaunchScreenState extends State<LaunchScreen> {
  @override
  void initState() {
    super.initState();
    initializeLocationAndSave();
  }

  void initializeLocationAndSave() async {
    Location location = Location();
    bool? serviceEnabled;
    PermissionStatus? permissionGranted;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
    }

    // Get the current user location
    LocationData locationData = await location.getLocation();
    LatLng currentLatLng =
        LatLng(locationData.latitude!, locationData.longitude!);

    sharedPreferences.setDouble('latitude', locationData.latitude!);
    sharedPreferences.setDouble('longitude', locationData.longitude!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('ParkRun'),
        ),
        body: Stack(fit: StackFit.expand, children: [
          MapView(
              startLatitude: 57.70715,
              startLongitude: 12.04727,
              mapMarkers: bandel_marks.all_markers),
          ChangeNotifierProvider(
            create: (context) => StateNotifierRoute("/first"),
            child: SelectionSectionModal(
              sectionNumbers: [
                SectionNumber(
                    sectionNumber: 1,
                    mapMarkers: bandel_marks.mapMarker_bandel_1,
                    title: "Section 1",
                    route: "/first"),
                SectionNumber(
                    sectionNumber: 2,
                    mapMarkers: bandel_marks.mapMarker_bandel_2,
                    title: "Section 2",
                    route: "/second"),
                SectionNumber(
                    sectionNumber: 3,
                    mapMarkers: bandel_marks.mapMarker_bandel_3,
                    title: "Section 3",
                    route: "/third"),
              ],
            ),
          )
        ]));
  }
}
