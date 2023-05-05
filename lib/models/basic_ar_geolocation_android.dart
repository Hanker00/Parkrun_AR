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
  double degree = 0;
  double bearing = 0;
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

  // Sandlådan hörn
  final double _flagPosLat = 57.688477555417116;
  final double _flagPosLong = 11.979252110033677;

  // Norra hörnet tyst läsesal biblioteket
  //final double _flagPosLat = 57.69057400876592;
  //final double _flagPosLong = 11.97894148654098;

  // J.A.
  // final double _flagPosLat = 57.68885845458837;
  // final double _flagPosLong = 11.97457805283622;

  // Blåa skylten utanför Emil livs
  //final double _flagPosLat = 57.68203623811061;
  //final double _flagPosLong = 11.984675124407316;

  // Norra hörnet tyst läsesal biblioteket
  // final double _flagPosLat = 57.69057400876592;
  // final double _flagPosLong = 11.97894148654098;
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

    // 1. plussa på distance i rätt riktning
    // 2. räkna ut dX dY från distance-offset-flagga till flaggan
    /* fauxFlagLat = position.latitude +
        (distanceToFlag / 1110000) * cos(vector.radians(_angle));
    fauxFlagLong = position.longitude +
        (distanceToFlag / 1110000) * sin(vector.radians(_angle));
    dX = (fauxFlagLat - _flagPosLat) * 111000;
    dZ = (fauxFlagLong - _flagPosLong) * 111000; */

    double latUser = position.latitude * pi / 180;
    double lonUser = position.longitude * pi / 180;
    double latFlag = _flagPosLat * pi / 180;
    double lonFlag = _flagPosLong * pi / 180;

    double deltaOmega =
        log(tan((latFlag / 2) + (pi / 4)) / tan((latUser / 2) + (pi / 4)));
    double deltaLongitude = (lonUser - lonFlag).abs();

    bearing = atan2(deltaLongitude, deltaOmega);
    double angleToFlag = (degreeFromUserToFlagPos + _angle) % 360;
    /*dX = (position.latitude - _flagPosLat).abs() *
        111000 *
        cos(vector.radians(_angle) + 90);
    dZ = (position.longitude - _flagPosLong).abs() *
        111000 *
        sin(vector.radians(_angle) + 90);*/
    degree = (360 - (bearing) * 180 / pi);
    dX = distanceToFlag * sin(pi * (angleToFlag) / 180);
    dZ = -1 * distanceToFlag * cos(pi * (angleToFlag) / 180);

    print("dX:   $dX     dZ:   $dZ ");
    print("Device angle: $_angle   Angle to flag: $angleToFlag");
  }

  //device compass
  void calculateDegree() {
    FlutterCompass.events!.listen((CompassEvent event) {
      double deviceDegrees = event.heading!;
      setState(() {
        if (deviceDegrees != null) {
          _angle = deviceDegrees < 0 ? 360 + deviceDegrees : deviceDegrees;
        }
        _angleToFlag = degreeFromUserToFlagPos - _angle;
        _angleToFlag = _angleToFlag < 0 ? 360 + _angleToFlag : _angleToFlag;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _getlocation(); //first run
    timer = Timer.periodic(
      const Duration(milliseconds: 100),
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
              child: Text('Angle to Flag $_angleToFlag ',
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
    final flagMaterial = ArCoreMaterial(
      color: Color.fromARGB(100, 5, 163, 255),
    );

    final flagShape = ArCoreCylinder(
      materials: [flagMaterial],
      radius: 2,
      height: 0.5,
    );
    _getlocation();
    final flagNode = ArCoreNode(
      shape: flagShape,
      // Vector3(X, Y, Z)
      /* . . . - . . .
         . .   Z   . .
         . . . . . . .
         - X . ↑ . X +
         . . . . . . .
         . . . Z . . .
         . . . + . . . 
         Y kanske är höjd idk*/
      position: vector.Vector3(dX, 0, dZ),
      rotation: vector.Vector4(0, 0, 0, 0),
    );

    // This delay gives time for the camera to initialize and find feature points
    await Future.delayed(Duration(seconds: 4));
    // Add
    arCoreController.addArCoreNodeWithAnchor(flagNode);
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
