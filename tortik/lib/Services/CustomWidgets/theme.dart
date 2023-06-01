import 'package:flutter/material.dart';
ThemeData theme(){
  return ThemeData(
    primaryColor: Colors.black87,
    scaffoldBackgroundColor: Colors.black87,
    primaryColorDark: const Color(0xFF5B2C6F),
    primaryColorLight: const Color(0xFFBDBDBD),
    fontFamily: 'Roboto',
    textTheme: const TextTheme(
      displayLarge: TextStyle(color: Colors.black,
        fontWeight: FontWeight.normal,
        fontSize: 26),
       displayMedium: TextStyle(color: Colors.black,
            fontWeight: FontWeight.normal,
            fontSize: 20),
        displaySmall: TextStyle(color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16)
    )
  );
}