import 'package:flutter/material.dart';

const Color colorPrimary = Color(0xFFFFA300);
const Color colorPrimaryLight = Color.fromARGB(255, 253, 200, 108);
const Color colorSecondary = Color(0xFF54bfb5);

// ignore: camel_case_types
class parkrunTheme {
class parkrunTheme {
  static ThemeData mainTheme() {
    return ThemeData(
      //theme for colors in app
      //theme for colors in app
      primaryColor: colorPrimary,
      applyElevationOverlayColor: true,
      colorScheme: colors(Brightness.light, colorPrimary),
      appBarTheme: const AppBarTheme(),
      listTileTheme: const ListTileThemeData(),
      
      splashColor: colorPrimary,

      //Theme for text
      textTheme: const TextTheme(
        displayLarge: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        displayMedium: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        displaySmall: TextStyle(fontSize: 15, fontWeight: FontWeight.normal),
      ),

      //styles for buttons widgets
      
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
        backgroundColor: colorPrimary,
        //minimumSize: Size(20, 20) ,
        //elevation: 5.0,
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