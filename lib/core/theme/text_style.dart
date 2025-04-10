import 'package:dance_up/core/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyles {
  // === Label - 10 ===
  static TextStyle labelRegular({Color color = AppColors.primary}) =>
      GoogleFonts.poppins(
          textStyle: TextStyle(
              fontSize: 14, fontWeight: FontWeight.w400, color: color));

  static TextStyle labelMedium({Color color = AppColors.primary}) =>
      GoogleFonts.poppins(
          textStyle: TextStyle(
              fontSize: 14, fontWeight: FontWeight.w500, color: color));

  static TextStyle labelBold({Color color = AppColors.primary}) =>
      GoogleFonts.poppins(
          textStyle: TextStyle(
              fontSize: 14, fontWeight: FontWeight.w700, color: color));

  // === Body - 16 ===
  static TextStyle bodyRegular({Color color = AppColors.primary}) =>
      GoogleFonts.poppins(
          textStyle: TextStyle(
              fontSize: 16, fontWeight: FontWeight.w400, color: color));

  static TextStyle bodyMedium({Color color = AppColors.primary}) =>
      GoogleFonts.poppins(
          textStyle: TextStyle(
              fontSize: 16, fontWeight: FontWeight.w500, color: color));

  static TextStyle bodyBold({Color color = AppColors.primary}) =>
      GoogleFonts.poppins(
          textStyle: TextStyle(
              fontSize: 16, fontWeight: FontWeight.w700, color: color));

  // === Title - 24 ===
  static TextStyle titleRegular({Color color = AppColors.primary}) =>
      GoogleFonts.poppins(
          textStyle: TextStyle(
              fontSize: 24, fontWeight: FontWeight.w400, color: color));

  static TextStyle titleMedium({Color color = AppColors.primary}) =>
      GoogleFonts.poppins(
          textStyle: TextStyle(
              fontSize: 24, fontWeight: FontWeight.w500, color: color));

  static TextStyle titleBold({Color color = AppColors.primary}) =>
      GoogleFonts.poppins(
          textStyle: TextStyle(
              fontSize: 24, fontWeight: FontWeight.w700, color: color));

  // === Big Title - 32 ===
  static TextStyle bigTitleRegular({Color color = AppColors.primary}) =>
      GoogleFonts.poppins(
          textStyle: TextStyle(
              fontSize: 32, fontWeight: FontWeight.w400, color: color));

  static TextStyle bigTitleMedium({Color color = AppColors.primary}) =>
      GoogleFonts.poppins(
          textStyle: TextStyle(
              fontSize: 32, fontWeight: FontWeight.w500, color: color));

  static TextStyle bigTitleBold({Color color = AppColors.primary}) =>
      GoogleFonts.poppins(
          textStyle: TextStyle(
              fontSize: 32, fontWeight: FontWeight.w700, color: color));
}
