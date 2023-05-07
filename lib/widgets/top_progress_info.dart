import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:parkrun_ar/models/map_markers/map_marker.dart';
import 'package:parkrun_ar/models/providers/route_directions_model.dart';
import 'package:parkrun_ar/screens/navigation_view.dart';
import 'package:provider/provider.dart';

class TopProgressInfo extends StatefulWidget {
  final List<MapMarker> mapMarkers;
  final double distance;
  final double duration;
  const TopProgressInfo(
      {super.key,
      required this.mapMarkers,
      required this.distance,
      required this.duration});

  @override
  State<TopProgressInfo> createState() => _TopProgressInfoState();
}

// This widget will show the time and distance remaining
// Is currently static, needs to be connected to the actual values further on
class _TopProgressInfoState extends State<TopProgressInfo> {
  late LatLng current;
  @override
  void dispose() {
    super.dispose();
  }

  Future<Position> getCurrentPos() async {
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
    current = LatLng(currentPos.latitude, currentPos.longitude);
    return currentPos;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getCurrentPos(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Row(
              children: [
                const Padding(
                    padding: EdgeInsets.only(left: 18, top: 35, bottom: 35)),
                Text(
                  "${widget.duration.toInt()} min",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 30),
                ),
                Text(
                  " (${widget.distance} km)",
                  style: const TextStyle(color: Colors.grey, fontSize: 28),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(right: 18),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                ChangeNotifierProvider<RouteDirectionsModel>(
                                  create: (context) => RouteDirectionsModel(),
                                  builder: (context, child) => NavigationView(
                                      mapMarkers: widget.mapMarkers,
                                      startLatitude:
                                          widget.mapMarkers[0].startLatitude,
                                      startLongitude:
                                          widget.mapMarkers[0].startLongitude,
                                      firstPos: current),
                                )),
                      );
                    },
                    style: Theme.of(context).elevatedButtonTheme.style,
                    child: Text(
                      "Start",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                ),
              ],
            );
          } else {
            return const CircularProgressIndicator();
          }
        });
  }
}
