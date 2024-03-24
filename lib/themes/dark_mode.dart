import 'package:flutter/material.dart';

ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  colorScheme: const ColorScheme.dark(
    background: Color.fromARGB(255, 20, 20, 20),
    //primary: const Color.fromARGB(255, 122, 122, 122),
    primary: Colors.white,
    secondary: Color.fromARGB(255, 30, 30, 30),
    tertiary: Color.fromARGB(255, 47, 47, 47),
    inversePrimary: Colors.black,
  ),
  // textTheme: ThemeData.dark().textTheme.apply(
  //   bodyColor: Colors.grey[800],
  //   displayColor: Colors.white
  // )
);