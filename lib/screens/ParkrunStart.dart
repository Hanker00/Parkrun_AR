import 'package:flutter/material.dart';
import 'package:parkrun_ar/screens/bandel_1.dart';
import 'package:parkrun_ar/screens/Bandel2.dart';

import '../widgets/MainHeader.dart';
import '../widgets/NavButton.dart';

class ParkrunStart extends StatelessWidget {
  final String title;

  const ParkrunStart({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(title),
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
                  child: NavButton(
                    route: Bandel1(),
                    name: Text("Bandel 1"),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: SizedBox(
                    height: 50,
                    width: 314,
                    child: NavButton(route: Bandel2(), name: Text("Bandel 2"))),
              ),
            ],
          ),
        ));
  }
}
