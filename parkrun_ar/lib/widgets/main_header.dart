import 'package:flutter/material.dart';

class MainHeader extends StatelessWidget {
  final Color textColor;
  final String text;
  const MainHeader({
    super.key,
    required this.textColor,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Text(
      text,
      style: TextStyle(
        color: textColor,
        fontWeight: FontWeight.bold,
        fontSize: 20,
      ),
    ));
  }
}
