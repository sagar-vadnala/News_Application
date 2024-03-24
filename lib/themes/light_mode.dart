import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    background: Colors.grey.shade300,
    primary: Colors.black,
    secondary: Colors.grey.shade100,
    tertiary: Colors.white,
    inversePrimary: Color.fromARGB(255, 200, 199, 199),
  ),
  // textTheme: ThemeData.light().textTheme.apply(
  //   bodyColor: Colors.grey[800],
  //   displayColor: Colors.black
  // )
);