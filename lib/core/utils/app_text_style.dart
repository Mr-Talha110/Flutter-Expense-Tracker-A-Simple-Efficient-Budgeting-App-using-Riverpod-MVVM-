import 'package:expense_tracker_app/core/utils/app_colors.dart';
import 'package:expense_tracker_app/core/utils/app_fonts.dart';
import 'package:flutter/material.dart';

class AppTextStyle {
  static const TextStyle largeTitle = TextStyle(
    fontSize: 38,
    fontWeight: FontWeight.w500,
    color: AppColors.black,
    fontFamily: AppFonts.robotoMedium,
  );
  static const TextStyle mainTitle = TextStyle(
    fontSize: 23,
    fontWeight: FontWeight.w500,
    color: AppColors.black,
    fontFamily: AppFonts.robotoMedium,
  );
  static const TextStyle bodyLarge = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w400,
    color: AppColors.black,
    fontFamily: AppFonts.robotoMedium,
  );
  static const TextStyle bodyMedium = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: AppColors.black,
    fontFamily: AppFonts.robotoMedium,
  );
  static const TextStyle bodySmall = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w400,
    fontFamily: AppFonts.robotoMedium,
  );
}
