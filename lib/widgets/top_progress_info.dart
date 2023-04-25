import 'package:flutter/material.dart';
import 'package:parkrun_ar/models/map_markers/map_marker.dart';
import 'package:parkrun_ar/screens/navigation_view.dart';

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
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Padding(padding: EdgeInsets.only(left: 18, top: 35, bottom: 35)),
        Text(
          "${widget.duration.toInt()} min",
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
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
                    builder: (context) => NavigationView(
                        mapMarkers: widget.mapMarkers,
                        startLatitude: widget.mapMarkers[0].startLatitude,
                        startLongitude: widget.mapMarkers[0].startLongitude)),
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
  }
}
