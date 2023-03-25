import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:parkrun_ar/widgets/all_stepper.dart';
import 'package:parkrun_ar/widgets/stepper_widget_inheritance.dart';

import '../models/map_markers/direction_marker.dart';

class Bandel2 extends StatelessWidget {
  const Bandel2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Bandel 2")), body: Bandel_2_stepper());
  }
}
