import 'package:flutter/material.dart';
import 'package:parkrun_ar/screens/bandel_1.dart';
import 'package:parkrun_ar/screens/bandel_2.dart';
import 'package:parkrun_ar/widgets/draggable_bottom_sheet.dart';

import '../widgets/MainHeader.dart';
import '../widgets/NavButton.dart';

class ParkrunStart extends StatelessWidget {
  const ParkrunStart({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('ParkRun'),
        ),
        body: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
          ),
          child: ListView(
            children: const <Widget>[
              Padding(
                padding: const EdgeInsets.all(20),
                child: SizedBox(
                  height: 50,
                  width: 314,
                  child: NavButton(route: '/first', name: Text('Bandel 1')),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: SizedBox(
                    height: 50,
                    width: 314,
                    child: NavButton(route: '/second', name: Text('Bandel 2'))),
              ),
            ],
          ),
        ));
  }
}
