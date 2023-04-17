import 'package:ar_flutter_plugin/models/ar_hittest_result.dart';
import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' as vector;
import 'dart:async';
import 'dart:math';
import 'info.dart';
import 'package:arkit_plugin/arkit_plugin.dart';
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

  int _angle = 0;
  double distanceToFlag = 0;
  int _distance = 0;
  double degreeFromUserToFlagPos = 0;
  double dX = 0;
  double dY = 0;
  bool updateNode = false;

  // J.A. innegård
  //final double _flagPosLat = 57.68862643251456;
  //final double _flagPosLong = 11.974664533620052;

  // Sandlådan
  final double _flagPosLat = 57.68850504306074;
  final double _flagPosLong = 11.979067324351785;

  // Utanför bilbioteket
  //final double _flagPosLat = 57.69077993841609;
  //final double _flagPosLong = 11.97887268196273;
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
    brng = 360 - brng; //remove to make clockwise
    return brng;
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

    dX = (position.latitude - _flagPosLat) * 111000; //sin
    dY = (position.longitude - _flagPosLong) * 111000; // cos
    calculateDegree();
  }

  //device compass
  void calculateDegree() {
    FlutterCompass.events!.listen((CompassEvent event) {
      double? deviceDegrees = event.heading;
      setState(() {
        if (deviceDegrees != null) {
          _angle = (deviceDegrees).truncate();
        }
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _getlocation(); //first run
    timer = Timer.periodic(
      const Duration(seconds: 2),
      (timer) {
        _getlocation();
        print("dX: " + dX.toString() + " dY: " + dY.toString());
        if (distanceToFlag < 50 && distanceToFlag != 0) {
          setState(
            () {
              print("Within distance test");
              situationDistance = WidgetDistance.ready;
              situationCompass = WidgetCompass.scanning;
            },
          );
        } else {
          setState(
            () {
              print("Outside distance test");
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
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.help),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) => CustomDialog());
            },
          )
        ],
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
              child: Text(' Angle from u to f : $degreeFromUserToFlagPos ',
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
        /*ArCoreView(
          onArCoreViewCreated: (controller) => {
            arCoreController = controller,
            print("WTF"),
          },
        ),*/
        Column(
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(' Angle to flag : $degreeFromUserToFlagPos m.',
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
    print("Crash 2 test");
    arCoreController = controller;
    arCoreController.onNodeTap = (name) => onTapHandler(name);
    _addNodeOnPlaneDetected();
  }

  Future<void> _addNodeOnPlaneDetected() async {
    final moonMaterial = ArCoreMaterial(color: Colors.grey);

    final moonShape = ArCoreSphere(
      materials: [moonMaterial],
      radius: distanceToFlag / 60,
    );

    final moon = ArCoreNode(
      shape: moonShape,
      // Vector3(dY, 0, dX)
      /* . . . - . . .
         . .   X   . .
         . . . . . . .
         - Z . ↑ . Z +
         . . . . . . .
         . . . X . . .
         . . . + . . . 
         Y kanske är höjd idk*/
      position: vector.Vector3(-dY, 0.0, dX),
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
    updateNode = true;
  }

  void onTapHandler(String name) {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) =>
          AlertDialog(content: Text('onNodeTap on $name')),
    );
  }

  void _addFlagNodeToWorld() async {
    print("Crash 1 test");
    // create a fixed node at the specified latitude and longitude
    fixedNode = ArCoreReferenceNode(
      name: 'flag',
      objectUrl:
          "https://github.com/KhronosGroup/glTF-Sample-Models/raw/master/2.0/Fox/glTF-Binary/Fox.glb",
      position: vector.Vector3(16.0, 16.0, -20.0),
      //vector.Vector3(dX, dY, -distanceToFlag),
      rotation: vector.Vector4(0, 0, 0, 0), //_calculateRotation(),
      scale: vector.Vector3(1, 1, 1),
    );

    /*fixedNode2 = ArCoreNode(
      name: 'flag2',
      shape: ArCoreSphere(
        materials: [
          ArCoreMaterial(
            color: Colors.amber,
          ),
        ],
        radius: 1,
      ),
      position: vector.Vector3(dX * 1, dY * 1, -distanceToFlag),
      rotation: _calculateRotation(),
      scale: vector.Vector3(1, 1, 1),
    );*/

    print("Crash 3 test");
    // add the fixed node to the scene
    // addArCoreNodeWithAnchor ger
    await Future.delayed(Duration(seconds: 2));
    //arCoreController.addArCoreNode(fixedNode);
    arCoreController.addArCoreNodeWithAnchor(fixedNode);
    //arCoreController.addArCoreNodeWithAnchor(fixedNode2);
  }

  vector.Vector3 _getFlagPosition() {
    print("Crash 4 test");
    return vector.Vector3(dX * 4, dY * 4, distanceToFlag);
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
    return FloatingActionButton(
      backgroundColor: Colors.blue,
      onPressed: null,
      child: RotationTransition(
        turns: AlwaysStoppedAnimation(
            _angle > 0 ? _angle / 360 : (_angle + 360) / 360),
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
        return navigateWidget();
    }
  }

  @override
  void dispose() {
    arCoreController.dispose();
    super.dispose();
  }
}
