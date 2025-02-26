import 'package:flutter/material.dart';

ThemeData appTheme = ThemeData(
  // colorSchemeSeed: AppColors.primary,
  useMaterial3: false,
  // fontFamily: AppFonts.ralewayRegular,

  // Scaffold background color
  scaffoldBackgroundColor: Colors.white,

  // AppBar Theme
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.white,
    elevation: 4.0,
    shadowColor: Colors.black26,
    surfaceTintColor: Colors.transparent,
    centerTitle: true,
    iconTheme: IconThemeData(),
  ),

  //TEXT THEME
  textTheme: const TextTheme().apply(
    displayColor: Colors.black,
  ),
);
