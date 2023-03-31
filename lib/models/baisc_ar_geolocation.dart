import 'dart:async';
import 'dart:math';
import 'info.dart';
import 'package:arkit_plugin/arkit_plugin.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' as vector;
import 'package:geolocator/geolocator.dart';

class ImageDetectionPage extends StatefulWidget {
  @override
  _ImageDetectionPageState createState() => _ImageDetectionPageState();
}

enum WidgetDistance { ready, navigating }

enum WidgetCompass { scanning, directing }

class _ImageDetectionPageState extends State<ImageDetectionPage> {
  WidgetDistance situationDistance = WidgetDistance.navigating;
  WidgetCompass situationCompass = WidgetCompass.directing;

  late ARKitController arkitController;
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
        if (targetDegree != null && direction != null) {
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

    final double _facultypositionlat = 57.6893307687895;
    final double _facultypositionlong = 11.97438045320374;

    distance = await Geolocator.distanceBetween(position.latitude,
        position.longitude, _facultypositionlat, _facultypositionlong);

    targetDegree = angleFromCoordinate(position.latitude, position.longitude,
        _facultypositionlat, _facultypositionlong);
    calculateDegree();
  }

  @override
  void initState() {
    super.initState();
    _getlocation(); //first run
    timer = new Timer.periodic(Duration(seconds: 2), (timer) {
      _getlocation();
      if (distance < 50 && distance != 0 && distance != null) {
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
  void dispose() {
    arkitController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text('Fırat AR'),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.help),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) => CustomDialog());
              })
        ],
        flexibleSpace: Container(
          decoration: BoxDecoration(
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
          ARKitSceneView(
            detectionImagesGroupName: 'AR Resources',
            onARKitViewCreated: onARKitViewCreated,
          ),
          anchorWasFound
              ? Container()
              : Column(
                  //do something here...
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
          ARKitSceneView(
            detectionImagesGroupName: 'AR Resources',
            onARKitViewCreated: onARKitViewCreated,
          ),
          anchorWasFound
              ? Container()
              : Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(' Distance of Faculty : $_distance m.',
                          style: TextStyle(
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
            icon: Icon(Icons.remove_red_eye),
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
        turns: new AlwaysStoppedAnimation(_clearDirection > 0
            ? _clearDirection / 360
            : (_clearDirection + 360) / 360),
        //if you want you can add animation effect for rotate
        child: Ink(
          decoration: const ShapeDecoration(
            color: Colors.lightBlue,
            shape: CircleBorder(),
          ),
          child: IconButton(
            icon: Icon(Icons.arrow_upward),
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
    return directingWidget();
  }

  Widget distanceProvider() {
    switch (situationDistance) {
      case WidgetDistance.ready:
        return readyWidget();
      case WidgetDistance.navigating:
        return navigateWidget();
    }
    return navigateWidget();
  }

  void onARKitViewCreated(ARKitController arkitController) {
    this.arkitController = arkitController;
    ARKitImageAnchor imageAnchor = ARKitImageAnchor(
      "your_image_reference_name",
      vector.Vector2(2, 2),
      true,
      "your_node_name",
      "your_anchor_identifier",
      vector.Matrix4.translationValues(
          0, 0, -0.2), // Position the anchor 20 cm in front of the camera),
    );
    this.arkitController.onAddNodeForAnchor;
    onAnchorWasFound(imageAnchor);
  }

  void onAnchorWasFound(ARKitAnchor anchor) {
    if (anchor is ARKitImageAnchor) {
      //if you want to block AR while you aren't close to target > add "if (situationDistance==WidgetDistance.ready)" here
      setState(() => anchorWasFound = true);

      final materialCard = ARKitMaterial(
        lightingModelName: ARKitLightingModel.lambert,
      );

      final image =
          ARKitPlane(height: 0.4, width: 0.4, materials: [materialCard]);

      final targetPosition = anchor.transform.getColumn(3);
      final node = ARKitNode(
        geometry: image,
        position: vector.Vector3(
            targetPosition.x, targetPosition.y, targetPosition.z),
        eulerAngles: vector.Vector3.zero(),
      );
      arkitController.add(node);
    }
  }
}
