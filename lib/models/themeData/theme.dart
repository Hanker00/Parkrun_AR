import 'package:flutter/material.dart';

const Color colorPrimary = Color(0xFFFFA300);
const Color colorPrimaryLight = Color(0xFFffe768);
const Color colorSecondary = Color(0xFF54bfb5);

// ignore: camel_case_types
class parkrunTheme {
  static ThemeData mainTheme() {
    return ThemeData(
      primaryColor: colorPrimary,
      colorScheme: colors(Brightness.light, colorPrimary),
      appBarTheme: const AppBarTheme(),
      listTileTheme: const ListTileThemeData(),
      textTheme: const TextTheme(
        displayLarge: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        displayMedium: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        displaySmall: TextStyle(fontSize: 15, fontWeight: FontWeight.normal),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
        backgroundColor: colorPrimary,
        elevation: 6.0,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(35.0)),
      )),
    );
  }
}

ColorScheme colors(Brightness brightness, Color? targetColor) {
  return ColorScheme.fromSeed(
    seedColor: colorPrimary,
    brightness: brightness,
  );
}
