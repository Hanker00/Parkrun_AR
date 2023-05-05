import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart';
import 'package:parkrun_ar/models/providers/state_notifier_instructions.dart';
import 'package:parkrun_ar/models/map_markers/map_marker.dart';
import 'package:parkrun_ar/models/navigation_models/route_nav.dart';
import 'package:parkrun_ar/models/waypoint_polyline.dart';
import 'package:parkrun_ar/services/mapbox_service.dart';
import 'package:parkrun_ar/widgets/all_stepper.dart';
import 'package:parkrun_ar/widgets/cancel_route_button.dart';
import 'package:parkrun_ar/widgets/current_step.dart';
import 'package:parkrun_ar/widgets/draggable_bottom_sheet.dart';
import 'package:parkrun_ar/widgets/navigation_widgets/map_view_navigation.dart';
import 'package:parkrun_ar/widgets/navigation_widgets/navigation_instruction.dart';
import 'package:provider/provider.dart';

class NavigationView extends StatefulWidget {
  final double startLatitude;
  final double startLongitude;
  final List<MapMarker> mapMarkers;
  const NavigationView(
      {super.key,
      required this.startLatitude,
      required this.startLongitude,
      required this.mapMarkers});

  @override
  State<NavigationView> createState() => _NavigationViewState();
}

class _NavigationViewState extends State<NavigationView> {
  late MapboxService mapboxService;
  late Future<Response> directionsResponse;
  late Future<List<WaypointPolyLine>> futurePolylines;

  @override
  void initState() {
    super.initState();
    mapboxService = MapboxService();
    // fetches our future from service to fetch the polylines.
    directionsResponse = getCurrentPos();
  }

  Future<Response> getCurrentPos() async {
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

    Position currentPos = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.bestForNavigation);

    return mapboxService.getDirectionsWithCurrentPos(
        widget.mapMarkers, currentPos.latitude, currentPos.longitude);
  }

  final int _index = 0;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: directionsResponse,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<RouteNav> route = mapboxService.fetchSteps(snapshot.data!);
            return ChangeNotifierProvider(
                create: (context) => StateNotifierInstruction(
                    _index,
                    widget.mapMarkers,
                    route[0],
                    0,
                    route[0].legs[0].steps[0],
                    route[0].legs[0],
                    0,
                    -1),
                builder: (context, child) {
                  return Scaffold(
                    body: Stack(
                      fit: StackFit.expand,
                      children: [
                        MapViewNavigation(
                          // Switch to current location later
                          startLatitude: widget.startLatitude,
                          startLongitude: widget.startLongitude,
                          mapMarkers: widget.mapMarkers,
                          polylines:
                              mapboxService.fetchPolyLines(snapshot.data!),
                        ),
                        DraggableBottomSheet(children: [
                          Column(
                            children: const <Widget>[
                              CurrentStep(),
                              Divider(
                                height: 10,
                                thickness: 2,
                              ),
                              AllStepper(),
                              CancelRouteButton()
                            ],
                          )
                        ]),
                        NavigationInstruction(
                            step: context
                                .watch<StateNotifierInstruction>()
                                .currentStep,
                            distance: context
                                .watch<StateNotifierInstruction>()
                                .distanceToNext),
                      ],
                    ),
                  );
                });
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }
}
