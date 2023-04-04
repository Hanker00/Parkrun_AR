import 'package:flutter/material.dart';
import 'package:parkrun_ar/models/providers/StateNotifierRoute.dart';
import 'package:parkrun_ar/widgets/NavButton.dart';
import 'package:parkrun_ar/widgets/draggable_bottom_sheet.dart';
import 'package:parkrun_ar/widgets/drop_down_item.dart';
import 'package:provider/provider.dart';

import '../models/section_number.dart';

class SectionAccordion {
  SectionAccordion({
    required this.sectionNumber,
    this.isExpanded = false,
  });

  SectionNumber sectionNumber;
  bool isExpanded;
}

List<SectionAccordion> generateSections(List<SectionNumber> sectionNumbers) {
  return List<SectionAccordion>.generate(sectionNumbers.length, (int index) {
    return SectionAccordion(
      sectionNumber: sectionNumbers[index],
    );
  });
}

class SelectionSectionModal extends StatefulWidget {
  final List<SectionNumber> sectionNumbers;
  List<SectionAccordion> sectionAccordions;
  SelectionSectionModal({super.key, required this.sectionNumbers})
      : sectionAccordions = sectionNumbers
            .map((section) => SectionAccordion(
                sectionNumber: SectionNumber(
                    mapMarkers: section.mapMarkers,
                    sectionNumber: 0,
                    title: section.title,
                    route: section.route)))
            .toList();

  @override
  State<SelectionSectionModal> createState() => _SelectionSectionModalState();
}

class _SelectionSectionModalState extends State<SelectionSectionModal>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final notifierState = context.watch<StateNotifierRoute>();
    return DraggableBottomSheet(children: [
      const Padding(
        padding: EdgeInsets.all(8.0),
        child: Text(
          "Select a section to continue",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      _buildAccordion(),
      NavButton(route: notifierState.notifierRoute, name: const Text("Continue"))
    ]);
  }

  Widget _buildAccordion() {
    return ListView(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      children: widget.sectionNumbers
          .map((section) => Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(28)),
                child: DropDownItem(
                  section: section,
                ),
              ))
          .toList(),
    );
  }
}
