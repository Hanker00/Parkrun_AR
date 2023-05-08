import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:parkrun_ar/models/map_markers/map_marker.dart';
import 'package:vector_math/vector_math_64.dart' as vector;
import 'dart:async';
import 'dart:math';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:geolocator/geolocator.dart';

enum WidgetDistance { ready, navigating }

enum WidgetCompass { scanning, directing }

class BasicArGeolocation extends StatefulWidget {
  late final MapMarker flag;
  BasicArGeolocation({super.key, required this.flag});

  @override
  _BasicArGeolocationState createState() => _BasicArGeolocationState(flag);
}

class _BasicArGeolocationState extends State<BasicArGeolocation> {
  WidgetDistance situationDistance = WidgetDistance.navigating;
  WidgetCompass situationCompass = WidgetCompass.directing;

  final MapMarker flag;
  _BasicArGeolocationState(this.flag);

  late ArCoreController arCoreController;
  late ArCoreNode fixedNode;
  late ArCoreNode fixedNode2;

  double _angle = 0;
  int _distance = 0;
  double degree = 0;
  double bearing = 0;
  double distanceToFlag = 0;
  double degreeFromUserToFlagPos = 0;
  int flagAngle = 0;
  double dX = 0;
  double dZ = 0;
  double _angleToFlag = 0;

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
  void _getlocation(LatLng flagPos) async {
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

    distanceToFlag = Geolocator.distanceBetween(position.latitude,
        position.longitude, flagPos.latitude, flagPos.longitude);

    degreeFromUserToFlagPos = angleFromCoordinate(position.latitude,
        position.longitude, flagPos.latitude, flagPos.longitude);

    calculateDegree();

    double angleToFlag = (degreeFromUserToFlagPos + _angle) % 360;
    dX = distanceToFlag * sin(pi * (_angleToFlag) / 180);
    dZ = -1 * distanceToFlag * cos(pi * (_angleToFlag) / 180);
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
    _getlocation(flag.location); //first run
    timer = Timer.periodic(
      const Duration(milliseconds: 100),
      (timer) {
        _getlocation(flag.location);
        if (distanceToFlag < 50 &&
            distanceToFlag != 0 &&
            (_angleToFlag < 30 || _angleToFlag > 330)) {
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
            color: Colors.amber,
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
              child: Text(' Angle to flag : $_angleToFlag °.',
                  style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      backgroundColor: Colors.blueGrey,
                      color: Colors.white)),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(' Move view to ± 20° of flag.',
                  style: TextStyle(
                      fontSize: 24,
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
      color: const Color.fromARGB(100, 5, 163, 255),
    );

    final flagShape = ArCoreCylinder(
      materials: [flagMaterial],
      radius: 2,
      height: 0.5,
    );

    final flagMotherShape = ArCoreSphere(
      materials: [flagMaterial],
      radius: 0.01,
    );
    _getlocation(flag.location);
    final flagNode = ArCoreNode(
      shape: flagShape,
      name: "flag",
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

    final flagMother = ArCoreNode(
      shape: flagMotherShape,
      name: "flagMother",
      position: vector.Vector3(0, 0, 0),
      rotation: vector.Vector4(0, 0, 0, 0),
      children: [flagNode],
    );

    // This delay gives time for the camera to initialize and find feature points
    await Future.delayed(const Duration(seconds: 2));
    // Add node to scene
    arCoreController.addArCoreNodeWithAnchor(flagMother);
  }

  // Simple debug method. Shows flag name on tap
  void onTapHandler(String name) {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) =>
          AlertDialog(content: Text('onNodeTap on $name')),
    );
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
    arCoreController.removeNode(nodeName: "flagMother");
    arCoreController.dispose();
    super.dispose();
  }
}
