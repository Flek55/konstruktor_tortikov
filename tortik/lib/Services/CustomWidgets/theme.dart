import 'package:flutter/material.dart';
ThemeData theme(){
  return ThemeData(
        colorScheme: const ColorScheme(
            brightness: Brightness.light,
            primary: Colors.black87,
            onPrimary: Color(0xFF5B2C6F),
            secondary: Colors.white,
            onSecondary: Colors.white,
            tertiary: Colors.grey,
            error: Colors.red,
            onError: Colors.red,
            background: Colors.white,
            onBackground:  Colors.white ,
            surface: Colors.white,
            onSurface: Colors.white
        ),
        fontFamily: 'Roboto',
        textTheme: const TextTheme(
          displayLarge: TextStyle(
              color: Colors.black, fontWeight: FontWeight.normal, fontSize: 26),
          displayMedium: TextStyle(
              color: Colors.black, fontWeight: FontWeight.normal, fontSize: 20),
          displaySmall: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
          titleLarge: TextStyle(
              fontFamily: 'Roboto', fontSize: 25, color: Color(0xFFF4D5BC)),
          titleMedium: TextStyle(
              fontFamily: 'Roboto', fontSize: 13, color: Color(0xFF707B7C)),
        ));
  }

