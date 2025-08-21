import 'package:flutter/material.dart';

class AppColors {
  // Background
  static const Color backgroundWhiteDark = Color.fromARGB(255, 197, 198, 204);
  static const Color backgroundWhiteMedium = Color.fromARGB(255, 233, 233, 233);
  static const Color backgroundWhiteLight = Color.fromARGB(255, 245, 245, 245);

  static const Color backgroundBlackDark = Color.fromARGB(255, 26, 26, 26);
  static const Color backgroundBlackMedium = Color.fromARGB(255, 50, 50, 50);
  static const Color backgroundBlackLight = Color.fromARGB(255, 112, 112, 112);

  // Primary
  static const Color primaryDark = Color.fromARGB(255, 0, 123, 255);
  static const Color primaryMedium = Color.fromARGB(255, 27, 127, 255);
  static const Color primaryLight = Color.fromARGB(255, 96, 173, 255);
  static const Color primaryLightest = Color.fromARGB(255, 229, 242, 255);

  // Secondary
  static const Color secondaryDark = Color.fromARGB(255, 138, 43, 226);
  static const Color secondaryMedium = Color.fromARGB(255, 150, 65, 229);
  static const Color secondaryLight = Color.fromARGB(255, 182, 123, 236);

  // Tertiary
  static const Color tertiaryDark = Color.fromARGB(255, 57, 255, 20);
  static const Color tertiaryMedium = Color.fromARGB(255, 98, 255, 69);
  static const Color tertiaryLight = Color.fromARGB(255, 132, 255, 109);

  // Support
  static const Color successDark = Color.fromARGB(255, 0, 255, 112);
  static const Color successMedium = Color.fromARGB(255, 96, 255, 166);
  static const Color successLight = Color.fromARGB(255, 158, 255, 201);

  static const Color warningDark = Color.fromARGB(255, 246, 226, 0);
  static const Color warningMedium = Color.fromARGB(255, 249, 236, 96);
  static const Color warningLight = Color.fromARGB(255, 255, 248, 229);

  static const Color errorDark = Color.fromARGB(255, 255, 5, 25);
  static const Color errorMedium = Color.fromARGB(255, 255, 99, 112);
  static const Color errorLight = Color.fromARGB(255, 255, 226, 229);
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
