import 'package:parkrun_ar/models/section_number.dart';

class SectionAccordion {
  SectionAccordion({
    required this.sectionNumber,
    this.isExpanded = false,
  });

  SectionNumber sectionNumber;
  bool isExpanded;
}
