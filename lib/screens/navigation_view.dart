import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:parkrun_ar/models/map_markers/map_marker.dart';
import 'package:parkrun_ar/models/waypoint_polyline.dart';
import 'package:parkrun_ar/services/MapboxService.dart';
import 'package:parkrun_ar/widgets/all_stepper.dart';
import 'package:parkrun_ar/widgets/current_step.dart';
import 'package:parkrun_ar/widgets/draggable_bottom_sheet.dart';
import 'package:parkrun_ar/widgets/map_view.dart';
import 'package:parkrun_ar/widgets/map_view_navigation.dart';
import 'package:parkrun_ar/widgets/navigation_instruction.dart';
import 'package:parkrun_ar/widgets/stepper_widget_inheritance.dart';
import '../models/stepper_notifier_model.dart';
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
    directionsResponse = mapboxService.getDirections(widget.mapMarkers);
  }

  int _index = 0;
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => StateNotifierModel(_index, widget.mapMarkers),
        builder: (context, child) {
          return FutureBuilder(
              future: directionsResponse,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
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
                              AllStepper()
                            ],
                          )
                        ]),
                        NavigationInstruction(
                            instruction: mapboxService
                                .fetchSteps(snapshot.data!)[0]
                                .legs[
                                    context.watch<StateNotifierModel>().counter]
                                .steps[0]
                                .instruction,
                            distance: mapboxService
                                .fetchSteps(snapshot.data!)[0]
                                .legs[
                                    context.watch<StateNotifierModel>().counter]
                                .steps[0]
                                .distance as double),
                      ],
                    ),
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              });
        });
  }
}
