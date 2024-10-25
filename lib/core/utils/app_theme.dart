import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTheme {
  static final ThemeData appTheme = ThemeData(
    colorScheme:
        ColorScheme.fromSeed(seedColor: AppColors.primaryBackgroundColor),
    scaffoldBackgroundColor: AppColors.primaryBackgroundColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.primaryColor,
      elevation: 2,
      scrolledUnderElevation: 5,
      shadowColor: AppColors.primaryColor,
      foregroundColor: Colors.white,
    ),
  );
}
