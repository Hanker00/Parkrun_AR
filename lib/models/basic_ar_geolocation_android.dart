import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' as vector;
import 'dart:async';
import 'dart:math';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:geolocator/geolocator.dart';

class BasicArGeolocation extends StatefulWidget {
  @override
  _BasicArGeolocationState createState() => _BasicArGeolocationState();
}

enum WidgetDistance { ready, navigating }

enum WidgetCompass { scanning, directing }

class _BasicArGeolocationState extends State<BasicArGeolocation> {
  WidgetDistance situationDistance = WidgetDistance.navigating;
  WidgetCompass situationCompass = WidgetCompass.directing;

  late ArCoreController arCoreController;
  late ArCoreNode fixedNode;
  late ArCoreNode fixedNode2;

  double _angle = 0;
  double distanceToFlag = 0;
  int _distance = 0;
  double degreeFromUserToFlagPos = 0;
  int flagAngle = 0;
  double dX = 0;
  double dZ = 0;
  bool updateNode = false;
  double fauxFlagLat = 0;
  double fauxFlagLong = 0;
  double _angleToFlag = 0;

  // J.A. innegård
  // final double _flagPosLat = 57.68862643251456;
  // final double _flagPosLong = 11.974664533620052;

  // J.A.
  // final double _flagPosLat = 57.68885845458837;
  // final double _flagPosLong = 11.97457805283622;

  // Korsningen sandlådan
  // final double _flagPosLat = 57.68847196787774;
  // final double _flagPosLong = 11.979324513497126;

  // Norra hörnet tyst läsesal biblioteket
  // final double _flagPosLat = 57.69057400876592;
  // final double _flagPosLong = 11.97894148654098;

  // Utanför Emils livs på vägen
  final double _flagPosLat = 57.682132722737975;
  final double _flagPosLong = 11.984564814117958;

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
    return brng.truncateToDouble();
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

    distanceToFlag = Geolocator.distanceBetween(
        position.latitude, position.longitude, _flagPosLat, _flagPosLong);

    degreeFromUserToFlagPos = angleFromCoordinate(
        position.latitude, position.longitude, _flagPosLat, _flagPosLong);

    calculateDegree();
    double degreeBetweeenUserAndFlag = (_angle - degreeFromUserToFlagPos).abs();
    // 1. plussa på distance i rätt riktning
    // 2. räkna ut dX dY från distance-offset-flagga till flaggan
    /* fauxFlagLat = position.latitude +
        (distanceToFlag / 1110000) * cos(vector.radians(_angle));
    fauxFlagLong = position.longitude +
        (distanceToFlag / 1110000) * sin(vector.radians(_angle));
    dX = (fauxFlagLat - _flagPosLat) * 111000;
    dZ = (fauxFlagLong - _flagPosLong) * 111000; */

    dX = (position.latitude - _flagPosLat).abs() *
        111000 *
        cos(vector.radians(_angle) + 90);
    dZ = (position.longitude - _flagPosLong).abs() *
        111000 *
        sin(vector.radians(_angle) + 90);

    print("dX:   $dX     dZ:   $dZ");
  }

  //device compass
  void calculateDegree() {
    FlutterCompass.events!.listen((CompassEvent event) {
      double deviceDegrees = event.heading!;
      setState(() {
        if (deviceDegrees != null) {
          _angle = deviceDegrees < 0 ? 360 + deviceDegrees : deviceDegrees;
        }
        _angleToFlag = _angle - degreeFromUserToFlagPos;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _getlocation(); //first run
    timer = Timer.periodic(
      const Duration(milliseconds: 500),
      (timer) {
        _getlocation();
        if (distanceToFlag < 50 && distanceToFlag != 0) {
          setState(
            () {
              situationDistance = WidgetDistance.ready;
              situationCompass = WidgetCompass.scanning;
            },
          );
        } else {
          setState(
            () {
              _distance = distanceToFlag.truncate();
              situationDistance = WidgetDistance.navigating;
              situationCompass = WidgetCompass.directing;
            },
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: const Text('Parkrun AR'),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: <Color>[
                Color.fromARGB(190, 207, 37, 7),
                Colors.transparent
              ],
            ),
          ),
        ),
      ),
      body: distanceProvider(),
      floatingActionButton: compassProvider());

  Widget readyWidget() {
    {
      print("Yes");
    }
    return Stack(
      fit: StackFit.expand,
      children: [
        ArCoreView(
          onArCoreViewCreated: _onArCoreViewCreated,
          enableTapRecognizer: true,
        ),
        Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Distance to flag: $distanceToFlag ',
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      backgroundColor: Colors.blueGrey,
                      color: Colors.white)),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(' Device angle : $_angle ',
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      backgroundColor: Colors.blueGrey,
                      color: Colors.white)),
            ),
          ],
        ),
      ],
    );
  }

  /*void _onPress() {
    final node = ArCoreReferenceNode(
      name: "Cube",
      objectUrl:
          "https://github.com/KhronosGroup/glTF-Sample-Models/raw/master/2.0/Fox/glTF-Binary/Fox.glb",
      scale: vector.Vector3(0.2, 0.2, 0.2),
    );
    print("Should have added Chicken on target");
    // Add the node to the AR scene
    arCoreController.addArCoreNodeWithAnchor(node);
  }*/

  Widget navigateWidget() {
    return Stack(
      fit: StackFit.expand,
      children: [
        Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(' Angle to flag : $_angleToFlag m.',
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      backgroundColor: Colors.blueGrey,
                      color: Colors.white)),
            ),
          ],
        ),
      ],
    );
  }

  void _onArCoreViewCreated(ArCoreController controller) {
    arCoreController = controller;
    arCoreController.onNodeTap = (name) => onTapHandler(name);
    _addNodeOnPlaneDetected();
  }

  Future<void> _addNodeOnPlaneDetected() async {
    final moonMaterial = ArCoreMaterial(color: Colors.grey);

    final moonShape = ArCoreSphere(
      materials: [moonMaterial],
      radius: distanceToFlag / 30,
    );

    final moon = ArCoreNode(
      shape: moonShape,
      // Vector3(X, Y, Z)
      /* . . . - . . .
         . .   Z   . .
         . . . . . . .
         - X . ↑ . X +
         . . . . . . .
         . . . Z . . .
         . . . + . . . 
         Y kanske är höjd idk*/
      position: vector.Vector3(dX, 0.0, -dZ),
      rotation: vector.Vector4(0, 0, 0, 0),
    );

    final earthMaterial = ArCoreMaterial(
      color: Colors.blue,
    );

    final earthShape = ArCoreSphere(
      materials: [earthMaterial],
      radius: 0.03,
    );

    final earth = ArCoreNode(
      shape: earthShape,
      children: [moon],
      position: vector.Vector3(0, 0, 0.0),
      rotation: vector.Vector4(0, 0, 0, 0),
    );

    await Future.delayed(Duration(seconds: 2));

    arCoreController.addArCoreNodeWithAnchor(earth);
  }

  void onTapHandler(String name) {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) =>
          AlertDialog(content: Text('onNodeTap on $name')),
    );
  }

  vector.Vector3 _getFlagPosition() {
    return vector.Vector3(dX * 4, dZ * 4, distanceToFlag);
    //return vector.Vector3(3, 3, -1);
  }

  vector.Vector4 _calculateRotation() {
    // calculate the rotation based on the user's current heading
    double rotation = pi * degreeFromUserToFlagPos / 180;
    return vector.Vector4(0, sin(rotation / 2), 0, cos(rotation / 2));
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
    return const FloatingActionButton(
      backgroundColor: Colors.blue,
      onPressed: null,
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
        return navigateWidget();
    }
  }

  @override
  void dispose() {
    arCoreController.dispose();
    super.dispose();
  }
}
