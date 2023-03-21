import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:parkrun_ar/models/map_markers/direction_marker.dart';
import 'package:parkrun_ar/widgets/NavButton.dart';
import 'package:parkrun_ar/widgets/draggable_bottom_sheet.dart';
import 'package:tuple/tuple.dart';

import '../models/map_markers/kilometer_marker.dart';
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
  const SelectionSectionModal({super.key, required this.sectionNumbers});

  @override
  State<SelectionSectionModal> createState() => _SelectionSectionModalState();
}

class _SelectionSectionModalState extends State<SelectionSectionModal> {
  late List<SectionAccordion> _data;

  @override
  Widget build(BuildContext context) {
    _data = generateSections(widget.sectionNumbers);
    return DraggableBottomSheet(children: [
      Container(
        child: _buildAccordion(),
      )
    ]);
  }

  Widget _buildAccordion() {
    final List<SectionAccordion> _data =
        generateSections(widget.sectionNumbers);
    return ExpansionPanelList(
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          _data[index].isExpanded = !isExpanded;
        });
      },
      children: _data.map<ExpansionPanel>((SectionAccordion item) {
        return ExpansionPanel(
          headerBuilder: (BuildContext context, bool isExpanded) {
            return ListTile(
              title: Text(item.sectionNumber.title),
            );
          },
          body: ListTile(
              title: Text(item.sectionNumber.title),
              subtitle:
                  const Text('To delete this panel, tap the trash can icon'),
              trailing: const Icon(Icons.delete),
              onTap: () {
                setState(() {
                  _data.removeWhere(
                      (SectionAccordion currentItem) => item == currentItem);
                });
              }),
          isExpanded: item.isExpanded,
        );
      }).toList(),
    );
  }
}
