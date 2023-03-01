import "package:flutter/material.dart";
<<<<<<< Updated upstream:lib/screens/Bandel1.dart
import "../widgets/MapView.dart";
=======
import "package:parkrun_ar/widgets/main_header.dart";
>>>>>>> Stashed changes:lib/screens/bandel_1.dart

class Bandel1 extends StatelessWidget {
  const Bandel1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
<<<<<<< Updated upstream:lib/screens/Bandel1.dart
        backgroundColor: const Color.fromARGB(255, 33, 32, 32),
        title: const Text('Flutter MapBox'),
      ),
      body: Stack(
        children: const [
          MapView(startLatitude: 57.706650769336136, startLongitude: 12.052258936808373),
=======
        title: const Text('Bandel 1'),
      ),
      body: ListView(
        children: const [
          MainHeader(textColor: Colors.blue, text: 'Bandel 1'),
>>>>>>> Stashed changes:lib/screens/bandel_1.dart
        ],
      ),
    );
  }
}


