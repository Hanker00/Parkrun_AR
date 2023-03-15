import 'dart:math';

import 'package:flutter/material.dart';

class TopProgressInfo extends StatefulWidget {
  const TopProgressInfo({super.key});

  @override
  State<TopProgressInfo> createState() => _TopProgressInfoState();
}

class _TopProgressInfoState extends State<TopProgressInfo> with ChangeNotifier {
  @override
  Widget build(BuildContext context) {
    // var infoState = context.watch

    var distanceRemaining = 0;
    var timeRemaining = 0;
    return Row(
      children: const [
        Padding(padding: EdgeInsets.only(left: 18, top: 35, bottom: 35)),
        Text(
          "T min ",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
        ),
        Text(
          "(Dist m)",
          style: TextStyle(color: Colors.grey, fontSize: 28),
        ),
        Spacer()
      ],
    );
  }
}
