import 'package:flutter/material.dart';
import 'package:parkrun_ar/models/route_generator.dart';
import 'package:parkrun_ar/models/themeData/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'screens/ParkrunStart.dart';

late SharedPreferences sharedPreferences;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sharedPreferences = await SharedPreferences.getInstance();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      onGenerateRoute: GenerateRoute.generateRoute,
      title: 'Flutter Demo',
      theme: mainTheme,
    );
  }
}
