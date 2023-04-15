import 'package:flutter/material.dart';
import 'package:parkrun_ar/models/map_markers/specific_bandel_marker.dart';
import 'package:parkrun_ar/models/providers/StateNotifierRoute.dart';
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
              mapMarkers: bandel_marks.all_markers),
          ChangeNotifierProvider(
            create: (context) => StateNotifierRoute("/first"),
            child: SelectionSectionModal(
              sectionNumbers: [
                SectionNumber(
                    sectionNumber: 1,
                    mapMarkers: bandel_marks.mapMarker_bandel_1,
                    title: "Section 1",
                    route: "/first"),
                SectionNumber(
                    sectionNumber: 2,
                    mapMarkers: bandel_marks.mapMarker_bandel_2,
                    title: "Section 2",
                    route: "/second"),
                SectionNumber(
                    sectionNumber: 3,
                    mapMarkers: bandel_marks.mapMarker_bandel_3,
                    title: "Section 3",
                    route: "/third"),
              ],
            ),
          )
        ]));
  }
}
