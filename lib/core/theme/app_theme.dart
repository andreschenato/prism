import 'package:flutter/material.dart';

class AppColors {
  // Background
  static const Color backgroundWhiteDark = Color(0xc5c6ccff);
  static const Color backgroundWhiteMedium = Color(0xe9e9e9ff);
  static const Color backgroundWhiteLight = Color(0xf5f5f5ff);

  static const Color backgroundBlackDark = Color(0x1A1A1AFF);
  static const Color backgroundBlackMedium = Color(0x323232ff);
  static const Color backgroundBlackLight = Color(0x707070ff);

  // Primary
  static const Color primaryDark = Color(0x007bffff);
  static const Color primaryMedium = Color(0x1b89ffff);
  static const Color primaryLight = Color(0x60adffff);
  static const Color primaryLightest = Color(0xe5f2ffff);

  // Secondary
  static const Color secondaryDark = Color(0x8a2be2ff);
  static const Color secondaryMedium = Color(0x9641e5ff);
  static const Color secondaryLight = Color(0xb67becff);

  // Tertiary
  static const Color tertiaryDark = Color(0x39ff14ff);
  static const Color tertiaryMedium = Color(0x62ff45ff);
  static const Color tertiaryLight = Color(0x84ff6dff);

  // Support
  static const Color successDark = Color(0x2E8B57ff);
  static const Color successMedium = Color(0x4FBF8Dff);
  static const Color successLight = Color(0x9EFFC9ff);

  static const Color warningDark = Color(0xf6e200ff);
  static const Color warningMedium = Color(0xf9ec60ff);
  static const Color warningLight = Color(0xfff8e5ff);

  static const Color errorDark = Color(0xff0519ff);
  static const Color errorMedium = Color(0xff6370ff);
  static const Color errorLight = Color(0xffe2e5ff);
}

class AppTextStyles {
  static const TextStyle h1 = TextStyle(
    fontFamily: 'Inter',
    fontSize: 24,
    fontWeight: FontWeight.w700,
  );
  static const TextStyle h2 = TextStyle(
    fontFamily: 'Inter',
    fontSize: 18,
    fontWeight: FontWeight.w700,
  );
  static const TextStyle h3 = TextStyle(
    fontFamily: 'Inter',
    fontSize: 16,
    fontWeight: FontWeight.w800,
  );
  static const TextStyle h4 = TextStyle(
    fontFamily: 'Inter',
    fontSize: 14,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle bodyXL = TextStyle(
    fontFamily: 'Inter',
    fontSize: 18,
    fontWeight: FontWeight.w400,
  );
  static const TextStyle bodyL = TextStyle(
    fontFamily: 'Inter',
    fontSize: 16,
    fontWeight: FontWeight.w400,
  );
  static const TextStyle bodyM = TextStyle(
    fontFamily: 'Inter',
    fontSize: 14,
    fontWeight: FontWeight.w400,
  );
  static const TextStyle bodyS = TextStyle(
    fontFamily: 'Inter',
    fontSize: 12,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle actionL = TextStyle(
    fontFamily: 'Inter',
    fontSize: 14,
    fontWeight: FontWeight.w600,
  );
  static const TextStyle actionM = TextStyle(
    fontFamily: 'Inter',
    fontSize: 11,
    fontWeight: FontWeight.w400,
  );
  static const TextStyle actionS = TextStyle(
    fontFamily: 'Inter',
    fontSize: 10,
    fontWeight: FontWeight.w600,
  );
}

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.primaryLight,
    scaffoldBackgroundColor: AppColors.backgroundWhiteLight,
    textTheme: const TextTheme(
      titleLarge: AppTextStyles.h1,
      bodyMedium: AppTextStyles.bodyM,
    ),
    colorScheme: const ColorScheme.light(
      primary: AppColors.primaryLight,
      surface: AppColors.backgroundWhiteLight,
      error: AppColors.errorMedium,
    ).copyWith(error: AppColors.errorMedium),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColors.primaryDark,
    scaffoldBackgroundColor: AppColors.backgroundBlackDark,
    textTheme: const TextTheme(
      titleLarge: AppTextStyles.h1,
      bodyMedium: AppTextStyles.bodyM,
    ),
    colorScheme: const ColorScheme.dark(
      primary: AppColors.primaryDark,
      background: AppColors.backgroundBlackDark,
      error: AppColors.errorMedium,
    ).copyWith(error: AppColors.errorMedium),
  );
}
