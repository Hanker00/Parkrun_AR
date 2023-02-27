import 'package:flutter/material.dart';
import 'package:parkrun_ar/screens/Bandel1.dart';
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
      body: ListView(
        children: const [
          MainHeader(
            textColor: Colors.blue,
            text: 'Welcome to the park run app!',
          ),
          NavButton(
            name: Text("Bandel 1"),
            route: Bandel1(),
          ),
          NavButton(
            name: Text("Bandel 2"),
            route: Bandel2(),
          ),
        ],
      ),
    );
  }
}
