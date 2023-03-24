import 'dart:math';

import 'package:flutter/material.dart';

class TopProgressInfo extends StatefulWidget {
  const TopProgressInfo({super.key});

  @override
  State<TopProgressInfo> createState() => _TopProgressInfoState();
}

// This widget will show the time and distance remaining
// Is currently static, needs to be connected to the actual values further on
class _TopProgressInfoState extends State<TopProgressInfo> with ChangeNotifier {
  @override
  Widget build(BuildContext context) {
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
        const Spacer(),
        Padding(
          padding: const EdgeInsets.only(right: 18),
          child: ElevatedButton(
            onPressed: () {},
            style: Theme.of(context).elevatedButtonTheme.style,
            child: Text(
              "Start",
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
        ),
      ],
    );
  }
}
