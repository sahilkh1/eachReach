// lib/utils/themes.dart

import 'package:flutter/material.dart';

final ThemeData appTheme = ThemeData(
  primarySwatch: Colors.blue,
  accentColor: Colors.orange,
  scaffoldBackgroundColor: Colors.white,
  visualDensity: VisualDensity.adaptivePlatformDensity,
  fontFamily: 'Roboto',

  // Define text themes
  textTheme: TextTheme(
    headline1: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
    headline6: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
    bodyText2: TextStyle(fontSize: 16),
    // Add other text styles as needed
  ),

  // Define button themes
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      primary: Colors.blue, // Button background color
      onPrimary: Colors.white, // Button text color
      textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    ),
  ),

  // Define input decoration theme
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(),
    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    labelStyle: TextStyle(fontSize: 16),
  ),

  // Define app bar theme
  appBarTheme: AppBarTheme(
    color: Colors.blue,
    elevation: 4,
    iconTheme: IconThemeData(color: Colors.white),
    textTheme: TextTheme(
      headline6: TextStyle(fontSize: 20, color: Colors.white),
    ),
  ),

  // Other theme configurations...
);
