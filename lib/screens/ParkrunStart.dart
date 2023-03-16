import 'package:flutter/material.dart';
import 'package:parkrun_ar/screens/bandel_1.dart';
import 'package:parkrun_ar/screens/Bandel2.dart';
import 'package:geolocator/geolocator.dart';
import "../constants.dart";

import '../widgets/MainHeader.dart';
import '../widgets/NavButton.dart';

class ParkrunStart extends StatefulWidget {
  const ParkrunStart({super.key});

  @override
  State<ParkrunStart> createState() => _ParkrunStartState();
}

class _ParkrunStartState extends State<ParkrunStart> {
  bool servicestatus = false;
  bool haspermission = false;
  late LocationPermission permission;
  late Position position;

  @override
  void initState() {
    checkGPS();
    super.initState();
  }

  checkGPS() async {
    servicestatus = await Geolocator.isLocationServiceEnabled();
    if (servicestatus) {
      permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          print('Location permissions are denied');
        } else if (permission == LocationPermission.deniedForever) {
          print("'Location permissions are permanently denied");
        } else {
          haspermission = true;
        }
      } else {
        haspermission = true;
      }

      if (haspermission) {
        setState(() {
          // TO DO:
          // How content about the different "bandelar" to be selected
        });

        getStartLocation();
      }
    } else {
      print("GPS Service is not enabled, turn on GPS location");
      setState(() {
        // TO DO:
        // Make something happen when the user doesn't give location permission
      });
    }
  }

  getStartLocation() async {
    position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    AppConstants.startLatitude = position.latitude;
    AppConstants.startLongitude = position.longitude;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('ParkRun'),
        ),
        body: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
          ),
          child: ListView(
            children: const <Widget>[
              Padding(
                padding: const EdgeInsets.all(20),
                child: SizedBox(
                  height: 50,
                  width: 314,
                  child: NavButton(route: '/first', name: Text('Bandel 1')),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: SizedBox(
                    height: 50,
                    width: 314,
                    child: NavButton(route: '/second', name: Text('Bandel 2'))),
              ),
            ],
          ),
        ));
  }
}
