import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart';
import 'package:latlong2/latlong.dart';
import 'package:parkrun_ar/models/navigation_models/leg_nav.dart';
import 'package:parkrun_ar/models/navigation_models/step_nav.dart';
import 'package:parkrun_ar/models/providers/route_directions_model.dart';
import 'package:parkrun_ar/models/providers/state_notifier_instructions.dart';
import 'package:parkrun_ar/models/map_markers/map_marker.dart';
import 'package:parkrun_ar/models/navigation_models/route_nav.dart';
import 'package:parkrun_ar/models/waypoint_polyline.dart';
import 'package:parkrun_ar/services/mapbox_service.dart';
import 'package:parkrun_ar/widgets/all_stepper.dart';
import 'package:parkrun_ar/widgets/current_step.dart';
import 'package:parkrun_ar/widgets/draggable_bottom_sheet.dart';
import 'package:parkrun_ar/widgets/navigation_widgets/map_view_navigation.dart';
import 'package:parkrun_ar/widgets/navigation_widgets/navigation_instruction.dart';
import 'package:provider/provider.dart';

class NavigationView extends StatefulWidget {
  final double startLatitude;
  final double startLongitude;
  final List<MapMarker> mapMarkers;
  final LatLng firstPos;
  const NavigationView(
      {super.key,
      required this.startLatitude,
      required this.startLongitude,
      required this.mapMarkers,
      required this.firstPos});

  @override
  State<NavigationView> createState() => _NavigationViewState();
}

class _NavigationViewState extends State<NavigationView> {
  late MapboxService mapboxService;
  late Future<List<WaypointPolyLine>> futurePolylines;

  @override
  void initState() {
    super.initState();
    mapboxService = MapboxService();
    // fetches our future from service to fetch the polylines.
  }

  final int _index = 0;
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => StateNotifierInstruction(
            _index,
            widget.mapMarkers,
            RouteNav(distance: 0, duration: 0, legs: []),
            0,
            StepNav(
              distance: 0,
              instruction: "re calculating",
              location: [0, 0],
              maneuver: {},
            ),
            LegNav(distance: 0, duration: 0, steps: []),
            0,
            -1),
        child: Consumer<RouteDirectionsModel>(
          builder: (context, routeDirectionsModel, _) => FutureBuilder(
              future: routeDirectionsModel.getDirectionsResponse(
                widget.mapMarkers,
                widget.firstPos,
              ),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<RouteNav> route =
                      mapboxService.fetchSteps(snapshot.data! as Response);
                  final instruction = context.read<StateNotifierInstruction>();
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    instruction.update(route[0], 0, route[0].legs[0].steps[0],
                        route[0].legs[0], 0, -1);
                  });
                  return Scaffold(
                    body: Stack(
                      fit: StackFit.expand,
                      children: [
                        MapViewNavigation(
                          // Switch to current location later
                          startLatitude: widget.startLatitude,
                          startLongitude: widget.startLongitude,
                          mapMarkers: widget.mapMarkers,
                          polylines: mapboxService
                              .fetchPolyLines(snapshot.data! as Response),
                        ),
                        DraggableBottomSheet(children: [
                          Column(
                            children: const <Widget>[
                              CurrentStep(),
                              Divider(
                                height: 10,
                                thickness: 2,
                              ),
                              AllStepper()
                            ],
                          )
                        ]),
                        Consumer<StateNotifierInstruction>(
                          builder: (context, state, _) {
                            return NavigationInstruction(
                              step: state.currentStep,
                              distance: state.distanceToNext,
                            );
                          },
                        )
                      ],
                    ),
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              }),
        ));
  }
}
