import 'package:flutter/material.dart';
import 'package:parkrun_ar/screens/bandel_1.dart';
import 'package:parkrun_ar/screens/Bandel2.dart';

import '../widgets/Info_button.dart';
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
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: const <Widget>[
                  Expanded(
                    child: NavButton(
                      route: '/first',
                      name: Text('Bandel 1'),
                    ),
                  ),
                  InfoIconButton(
                    icon: Icon(Icons.info),
                    buttonColor: Colors.red,
                    infoText: 'Information for badel 1',
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: const <Widget>[
                  Expanded(
                    child: NavButton(
                      route: '/second',
                      name: Text('Bandel 2'),
                    ),
                  ),
                  InfoIconButton(
                    icon: Icon(Icons.info),
                    buttonColor: Colors.red,
                    infoText: 'Infomation for bandel 2',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
