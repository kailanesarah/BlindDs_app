import 'package:flutter/material.dart';
import 'package:blindds_app/presentation/ui/style/colors/app_colors.dart';

class AppThemes {
  // --- TEMA CLARO ---
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.bluePrimary,
    scaffoldBackgroundColor: AppColors.grayDefault,
    cardColor: AppColors.cardLight, // cor de destaque para cards

    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.bluePrimary,
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
      iconTheme: IconThemeData(color: Colors.white),
    ),

    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Colors.black87),
      bodyMedium: TextStyle(color: Colors.black87),
      bodySmall: TextStyle(color: Colors.black54),
      headlineSmall: TextStyle(color: AppColors.bluePrimary),
      titleMedium: TextStyle(color: Colors.black87),
    ),

    colorScheme: const ColorScheme.light(
      primary: AppColors.bluePrimary,
      secondary: AppColors.blueSecondary,
      surface: AppColors.grayDisabled,
      onSurface: Colors.black87,
    ),
  );

  // --- TEMA ESCURO ---
  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColors.blueSecondary,
    scaffoldBackgroundColor: AppColors.grayBlackSecondary,
    cardColor: AppColors.cardDark, // cor de destaque para cards no escuro

    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.blueActive,
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
      iconTheme: IconThemeData(color: Colors.white),
    ),

    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Colors.white),
      bodyMedium: TextStyle(color: Colors.white),
      bodySmall: TextStyle(color: Colors.white70),
      headlineSmall: TextStyle(color: AppColors.blueSecondary),
      titleMedium: TextStyle(color: Colors.white),
    ),

    colorScheme: const ColorScheme.dark(
      primary: AppColors.blueSecondary,
      secondary: AppColors.blueSecondaryHover,
      surface: AppColors.grayBlackSecondary,
      onSurface: Colors.white,
    ),
  );
}
