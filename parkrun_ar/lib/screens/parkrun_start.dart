import 'package:flutter/material.dart';
import 'package:parkrun_ar/screens/bandel_1.dart';
import 'package:parkrun_ar/screens/bandel_2.dart';

import '../widgets/main_header.dart';
import '../widgets/nav_button.dart';

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
