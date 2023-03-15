import 'package:flutter/material.dart';
import 'package:parkrun_ar/screens/bandel_1.dart';
import 'package:parkrun_ar/widgets/Info_button.dart';

import '../widgets/MainHeader.dart';
import '../widgets/NavButton.dart';

class ParkrunStart extends StatelessWidget {
  final String title;
  const ParkrunStart({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: ListView(
        children: [
          const MainHeader(
            textColor: Colors.blue,
            text: 'Welcome to the park run app!',
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Expanded(
                  child: NavButton(
                    name: Text("Bandel 1"),
                    route: Bandel1(),
                  ),
                ),
                Row(
                  children: const [
                    InfoIconButton(
                      infoText: 'bandel information',
                      icon: Icon(Icons.info),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Expanded(
                  child: NavButton(
                    name: Text("Bandel 1"),
                    route: Bandel1(),
                  ),
                ),
                Row(
                  children: const [
                    InfoIconButton(
                      infoText: 'bande2 information',
                      icon: Icon(Icons.info),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
