import 'package:dance_up/core/theme/colors.dart';
import 'package:dance_up/core/theme/text_style.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      scaffoldBackgroundColor: AppColors.background,
      primaryColor: AppColors.primary,
      colorScheme: const ColorScheme.light(
        primary: AppColors.primary,
        secondary: AppColors.secondary,
        surface: AppColors.background,
        error: AppColors.red,
      ),
      textTheme: TextTheme(
        labelSmall: AppTextStyles.labelRegular(),
        labelMedium: AppTextStyles.labelMedium(),
        labelLarge: AppTextStyles.labelBold(),
        bodySmall: AppTextStyles.bodyRegular(),
        bodyMedium: AppTextStyles.bodyMedium(),
        bodyLarge: AppTextStyles.bodyBold(),
        titleSmall: AppTextStyles.titleRegular(),
        titleMedium: AppTextStyles.titleMedium(),
        titleLarge: AppTextStyles.titleBold(),
        displaySmall: AppTextStyles.bigTitleRegular(),
        displayMedium: AppTextStyles.bigTitleMedium(),
        displayLarge: AppTextStyles.bigTitleBold(),
      ),
      useMaterial3: true,
    );
  }
}
