import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTheme {
  static final ThemeData appTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primaryColor),
    scaffoldBackgroundColor: AppColors.primaryBackgroundColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.primaryColor,
      elevation: 2,
      scrolledUnderElevation: 5,
      shadowColor: AppColors.primaryColor,
      foregroundColor: AppColors.foregroundColor,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryColor,
        foregroundColor: AppColors.foregroundColor,
      ),
    ),
    iconTheme: const IconThemeData(color: AppColors.iconsColor),
    cardTheme: CardTheme(
      elevation: 5,
      margin: const EdgeInsets.symmetric(vertical: 5),
      color: AppColors.cardBackgroundColor,
      shadowColor: AppColors.primaryBackgroundColor,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: AppColors.primaryColor.withOpacity(.3)),
        borderRadius: BorderRadius.circular(16),
      ),
    ),
    splashColor: AppColors.primaryColor,
  );
}
