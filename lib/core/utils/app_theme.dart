import 'package:expense_tracker_app/core/utils/app_fonts.dart';
import 'package:flutter/material.dart';

ThemeData appTheme = ThemeData(
  useMaterial3: false,
  fontFamily: AppFonts.robotoRegular,

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
