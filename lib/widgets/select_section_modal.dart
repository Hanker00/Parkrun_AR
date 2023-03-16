import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:parkrun_ar/widgets/NavButton.dart';
import 'package:tuple/tuple.dart';

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
  @override
  Widget build(BuildContext context) {
    List<Tuple2<String, String>> routesAndTitle = [
      Tuple2<String, String>('/first', 'Bandel 1'),
      Tuple2<String, String>('/second', 'Bandel 2')
    ];
    String selectedRoute = "";
    List<SectionAccordion> _data = generateSections(widget.sectionNumbers);

    return DraggableScrollableSheet(
      initialChildSize: .2,
      minChildSize: .1,
      maxChildSize: .9,
      builder: (BuildContext context, ScrollController scrollController) {
        // SingleChildScrollView makes sure the whole sheet scrolls together
        return SingleChildScrollView(
          controller: scrollController,
          // This container adds the coloured bar on top
          child: Column(
            children: [
              Container(
                decoration: const BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                // This column holds the actual content
                child: Column(
                  children: [
                    const SizedBox(height: 4),
                    // This row contains the small "scrollable" indicator
                    Row(
                      children: [
                        const Spacer(),
                        Container(
                          height: 8,
                          width: 70,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.0),
                            color: Colors.amberAccent,
                          ),
                        ),
                        const Spacer(),
                      ],
                    ),
                    const SizedBox(height: 4),
                  ],
                ),
              ),
              ExpansionPanelList(
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
                        subtitle: const Text(
                            'To delete this panel, tap the trash can icon'),
                        trailing: const Icon(Icons.delete),
                        onTap: () {
                          setState(() {
                            _data.removeWhere((SectionAccordion currentItem) =>
                                item == currentItem);
                          });
                        }),
                    isExpanded: item.isExpanded,
                  );
                }).toList(),
              ),
            ],
          ),
        );
      },
    );
  }
}