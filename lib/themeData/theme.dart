
import 'package:flutter/material.dart';

const Color colorPrimary = Color(0xFFFFA300);
const Color colorPrimaryLight = Color(0xFFffe768);
const Color colorSecondary = Color(0xFF54bfb5);

ThemeData mainTheme = ThemeData(
  primaryColor: colorPrimary,
  
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
        EdgeInsets.symmetric(horizontal: 40.0,vertical: 20.0)
      ),
      shape: MaterialStateProperty.all<OutlinedBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0))
      ),
      backgroundColor: MaterialStateProperty.all<Color>(colorPrimaryLight)
    )
  ),
);