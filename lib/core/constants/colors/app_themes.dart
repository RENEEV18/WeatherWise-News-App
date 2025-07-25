import 'package:flutter/material.dart';
import 'package:weatherwise_news_app/core/constants/colors/colors.dart';

// The Class Represents The App Themes - Such as Light/Dark.
class AppTheme {
  /// Light Theme
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.primaryBlue,
    scaffoldBackgroundColor: AppColors.primaryWhite,
    colorScheme: ColorScheme.light(
      primary: AppColors.primaryBlue,
      onPrimary: AppColors.whiteText,
      secondary: Colors.blueAccent,
    ),
    textTheme: const TextTheme(
      titleLarge: TextStyle(color: AppColors.blackText),
      bodyMedium: TextStyle(color: AppColors.blackText),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.primaryBlue,
      foregroundColor: AppColors.whiteText,
    ),
  );

  /// Dark Theme
  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColors.primaryBlue,
    scaffoldBackgroundColor: AppColors.darkBg,
    colorScheme: ColorScheme.dark(
      primary: AppColors.primaryBlue,
      onPrimary: AppColors.blackText,
      secondary: Colors.blueAccent,
    ),
    textTheme: const TextTheme(
      titleLarge: TextStyle(color: AppColors.whiteText),
      bodyMedium: TextStyle(color: AppColors.whiteText),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.darkBg,
      foregroundColor: AppColors.whiteText,
    ),
  );
}
