import 'package:flutter/material.dart';
import 'package:parkrun_ar/models/route_generator.dart';
import 'package:parkrun_ar/models/stepper_notifier_model.dart';
import 'package:parkrun_ar/models/themeData/theme.dart';
import 'package:provider/provider.dart';

final dynamic theme = parkrunTheme.mainTheme();

void main() {
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
      theme: theme,
    );
  }
}
