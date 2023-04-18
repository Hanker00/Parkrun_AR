import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:parkrun_ar/main.dart';

import '../widgets/NavButton.dart';

class ParkrunStart extends StatefulWidget {
  const ParkrunStart({super.key});

  @override
  State<ParkrunStart> createState() => _ParkrunStartState();
}

class _ParkrunStartState extends State<ParkrunStart> {
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

    sharedPreferences.setDouble('latitude', locationData.latitude!);
    sharedPreferences.setDouble('longitude', locationData.longitude!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('ParkRun'),
        ),
        body: Container(
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
          ),
          child: ListView(
            children: const <Widget>[
              Padding(
                padding: EdgeInsets.all(20),
                child: SizedBox(
                  height: 50,
                  width: 314,
                  child: NavButton(route: '/first', name: Text('Bandel 1')),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20),
                child: SizedBox(
                    height: 50,
                    width: 314,
                    child: NavButton(route: '/second', name: Text('Bandel 2'))),
              ),
              Padding(
                padding: EdgeInsets.all(20),
                child: SizedBox(
                    height: 50,
                    width: 314,
                    child: NavButton(route: '/third', name: Text('Bandel 3'))),
              ),
              Padding(
                padding: EdgeInsets.all(20),
                child: SizedBox(
                    height: 50,
                    width: 314,
                    child: NavButton(
                        route: '/test', name: Text('Test widgets here!!!'))),
              ),
            ],
          ),
        ));
  }
}
