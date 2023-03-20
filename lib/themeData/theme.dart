
import 'package:flutter/material.dart';
import 'package:material_color_utilities/material_color_utilities.dart';


const Color colorPrimary = Color(0xFFFFA300);
const Color colorPrimaryLight = Color(0xFFffe768);
const Color colorSecondary = Color(0xFF54bfb5);

ThemeData mainTheme = ThemeData(
  primaryColor: colorPrimaryLight,
 
colorScheme: colors(Brightness.light,colorPrimary
),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      shape: MaterialStateProperty.all<OutlinedBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0))
      ),
      backgroundColor: MaterialStateProperty.all<Color>(colorPrimary)
    )
  ),
); 
ColorScheme colors(Brightness brightness, Color? targetColor) {
   final dynamicPrimary = brightness == Brightness.light;
   return ColorScheme.fromSeed(
     seedColor: colorPrimary,
     brightness: brightness,
   );
 }