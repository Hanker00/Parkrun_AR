import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' as vector;
import 'dart:async';
import 'dart:math';
import 'info.dart';
import 'package:arkit_plugin/arkit_plugin.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:geolocator/geolocator.dart';

class HelloWorld extends StatefulWidget {
  @override
  _HelloWorldState createState() => _HelloWorldState();
}

enum WidgetDistance { ready, navigating }

enum WidgetCompass { scanning, directing }

class _HelloWorldState extends State<HelloWorld> {
  WidgetDistance situationDistance = WidgetDistance.navigating;
  WidgetCompass situationCompass = WidgetCompass.directing;

  late ArCoreController arCoreController;
  bool anchorWasFound = false;
  int _clearDirection = 0;
  double distance = 0;
  int _distance = 0;
  double targetDegree = 0;
  late Timer timer;

  //calculation formula of angel between 2 different points
  double angleFromCoordinate(
      double lat1, double long1, double lat2, double long2) {
    double dLon = (long2 - long1);

    double y = sin(dLon) * cos(lat2);
    double x = cos(lat1) * sin(lat2) - sin(lat1) * cos(lat2) * cos(dLon);

    double brng = atan2(y, x);

    brng = vector.degrees(brng);
    brng = (brng + 360) % 360;
    //brng = 360 - brng; //remove to make clockwise
    return brng;
  }

  //device compass
  void calculateDegree() {
    FlutterCompass.events!.listen((CompassEvent event) {
      double? direction = event.heading;
      setState(() {
        if (direction != null) {
          _clearDirection = targetDegree.truncate() - direction.truncate();
        }
      });
    });
  }

//distance between faculty and device coordinates
  void _getlocation() async {
    //if you want to check location service permissions use checkGeolocationPermissionStatus method
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    final double _facultypositionlat = 57.688668428213035;
    final double _facultypositionlong = 11.97427593309094;

    distance = Geolocator.distanceBetween(position.latitude, position.longitude,
        _facultypositionlat, _facultypositionlong);

    targetDegree = angleFromCoordinate(position.latitude, position.longitude,
        _facultypositionlat, _facultypositionlong);
    calculateDegree();
  }

  @override
  void initState() {
    super.initState();
    _getlocation(); //first run
    timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      _getlocation();
      if (distance < 50 && distance != 0) {
        setState(() {
          situationDistance = WidgetDistance.ready;
          situationCompass = WidgetCompass.scanning;
        });
      } else {
        setState(() {
          _distance = distance.truncate();
          situationDistance = WidgetDistance.navigating;
          situationCompass = WidgetCompass.directing;
        });
      }
      print("Distance to target: $distance");
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: const Text('Parkrun AR'),
        actions: <Widget>[
          IconButton(
              icon: const Icon(Icons.help),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) => CustomDialog());
              })
        ],
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: <Color>[
                Color.fromARGB(190, 207, 37, 7),
                Colors.transparent
              ])),
        ),
      ),
      body: distanceProvider(),
      floatingActionButton: compassProvider());

  Widget readyWidget() {
    return Container(
      child: Stack(
        fit: StackFit.expand,
        children: [
          ArCoreView(
            onArCoreViewCreated: onArCoreViewCreated,
          ),
          anchorWasFound
              ? Container()
              : Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(' Distance to flag : $_distance m.',
                          style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              backgroundColor: Colors.blueGrey,
                              color: Colors.white)),
                    ),
                  ],
                ),
        ],
      ),
    );
  }

  Widget navigateWidget() {
    return Container(
      child: Stack(
        fit: StackFit.expand,
        children: [
          ArCoreView(
            onArCoreViewCreated: onArCoreViewCreated,
          ),
          anchorWasFound
              ? Container()
              : Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(' Distance to flag : $_distance m.',
                          style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              backgroundColor: Colors.blueGrey,
                              color: Colors.white)),
                    ),
                  ],
                ),
        ],
      ),
    );
  }

  void onArCoreViewCreated(ArCoreController arCoreController) {
    this.arCoreController = arCoreController;
    //if you want to block AR while you aren't close to target > add "if (situationDistance==WidgetDistance.ready)" here
    if (situationDistance == WidgetDistance.ready) {
      _addCylinder(arCoreController);
      setState(() => anchorWasFound = true);
    }
  }

  Widget scanningWidget() {
    return FloatingActionButton(
      backgroundColor: Colors.blue,
      onPressed: null,
      child: Ink(
          decoration: const ShapeDecoration(
            color: Colors.lightBlue,
            shape: CircleBorder(),
          ),
          child: IconButton(
            icon: const Icon(Icons.remove_red_eye),
            color: Colors.white,
            onPressed: () {},
          )),
    );
  }

  Widget directingWidget() {
    return FloatingActionButton(
      backgroundColor: Colors.blue,
      onPressed: null,
      child: RotationTransition(
        turns: AlwaysStoppedAnimation(_clearDirection > 0
            ? _clearDirection / 360
            : (_clearDirection + 360) / 360),
        //if you want you can add animation effect for rotate
        child: Ink(
          decoration: const ShapeDecoration(
            color: Colors.lightBlue,
            shape: CircleBorder(),
          ),
          child: IconButton(
            icon: const Icon(Icons.arrow_upward),
            color: Colors.white,
            onPressed: () {},
          ),
        ),
      ),
    );
  }

  Widget compassProvider() {
    switch (situationCompass) {
      case WidgetCompass.scanning:
        return scanningWidget();
      case WidgetCompass.directing:
        return directingWidget();
    }
  }

  Widget distanceProvider() {
    switch (situationDistance) {
      case WidgetDistance.ready:
        return readyWidget();
      case WidgetDistance.navigating:
        anchorWasFound = true;
        return navigateWidget();
    }
  }

  void _addCylinder(ArCoreController controller) {
    final material = ArCoreMaterial(
      color: Colors.red,
      reflectance: 1.0,
    );
    final cylinder = ArCoreCylinder(
      materials: [material],
      radius: 3.0,
      height: 3.0,
    );
    final node = ArCoreNode(
      shape: cylinder,
    );
    controller.addArCoreNode(node);
    print("Loaded cylinder ");
  }

  @override
  void dispose() {
    arCoreController.dispose();
    super.dispose();
  }
}
