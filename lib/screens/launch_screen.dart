import 'package:flutter/material.dart';
import 'package:parkrun_ar/models/map_markers/specific_bandel_marker.dart';
import 'package:parkrun_ar/models/providers/state_notifier_route.dart';
import 'package:parkrun_ar/models/section_number.dart';
import 'package:parkrun_ar/widgets/map_view.dart';
import 'package:parkrun_ar/widgets/select_section_modal.dart';
import 'package:provider/provider.dart';

class LaunchScreen extends StatelessWidget {
  const LaunchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('ParkRun'),
        ),
        body: Stack(fit: StackFit.expand, children: [
          MapView(
              startLatitude: 57.70715,
              startLongitude: 12.04727,
              mapMarkers: BandelMarks.allMarkers),
          ChangeNotifierProvider(
            create: (context) => StateNotifierRoute("/"),
            child: SelectionSectionModal(
              sectionNumbers: [
                SectionNumber(
                    sectionNumber: 1,
                    mapMarkers: BandelMarks.mapMarkerBandel1,
                    title: "Section 1",
                    route: "/first"),
                SectionNumber(
                    sectionNumber: 2,
                    mapMarkers: BandelMarks.mapMarkerBandel2,
                    title: "Section 2",
                    route: "/second"),
                SectionNumber(
                    sectionNumber: 3,
                    mapMarkers: BandelMarks.mapMarkerBandel3,
                    title: "Section 3",
                    route: "/third"),
                SectionNumber(
                    sectionNumber: 4,
                    mapMarkers: BandelMarks.hubbenMarker,
                    title: "Hubben test",
                    route: "/hubben"),
              ],
            ),
          )
        ]));
  }
}
