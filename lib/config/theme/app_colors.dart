import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // ── Light palette (unchanged) ────────────────────────────────────────────
  static const Color primary = Color(0xFFDB2777); // pink-600
  static const Color primaryLight = Color(0xFFFCE7F3); // pink-100
  static const Color primaryLighter = Color(0xFFFDF2F8); // pink-50
  static const Color background = Color(0xFFF9FAFB); // gray-50
  static const Color surface = Colors.white; // white
  static const Color textPrimary = Color(0xFF111827); // gray-900
  static const Color textSecondary = Color(0xFF4B5563); // gray-600
  static const Color iconColor = Color(0xFF4B5563); // gray-600
  static const Color error = Color(0xFFD4183D);
  static const Color border = Color(0xFFE5E7EB); // gray-200
  static const Color shadowColor = Color(0x33000000); // Black with 20% opacity
  static const Color info = Color(0xFF1E40AF);
  static const Color success = Color(0xFF16A34A);
  static const Color successBackground = Color(0xFFDCFCE7);
  static const Color popupBackground = Color(0x80000000);

  // ── Dark palette ─────────────────────────────────────────────────────────
  static const Color darkBackground = Color(0xFF000000); // gray-900
  static const Color darkSurface = Color(0xFF171717); // gray-800
  static const Color darkTextPrimary = Color(0xFFF9FAFB); // gray-50
  static const Color darkTextSecondary = Color(0xFF9CA3AF); // gray-400
  static const Color darkIconColor = Color(0xFF9CA3AF); // gray-400
  static const Color darkBorder = Color(0x26FFFFFF); // gray-700
  static const Color darkPrimaryLight = Color(0xFF831843); // pink-900
  static const Color darkPrimaryLighter = Color(0xFF500724); // pink-950
  static const Color darkSuccessBackground = Color(0xFF052E16);
  static const Color darkShadowColor = Color(0x40000000);
}

class AppColorScheme {
  final bool isDark;

  AppColorScheme(this.isDark);

  Color get primary => isDark ? AppColors.darkPrimaryLight : AppColors.primary;
  Color get primaryLight =>
      isDark ? AppColors.darkPrimaryLight : AppColors.primaryLight;
  Color get primaryLighter =>
      isDark ? AppColors.darkPrimaryLighter : AppColors.primaryLighter;

  Color get background =>
      isDark ? AppColors.darkBackground : AppColors.background;
  Color get surface => isDark ? AppColors.darkSurface : AppColors.surface;

  Color get textPrimary =>
      isDark ? AppColors.darkTextPrimary : AppColors.textPrimary;
  Color get textSecondary =>
      isDark ? AppColors.darkTextSecondary : AppColors.textSecondary;
  Color get iconColor => isDark ? AppColors.darkIconColor : AppColors.iconColor;
  Color get border => isDark ? AppColors.darkBorder : AppColors.border;
  Color get successBackground =>
      isDark ? AppColors.darkSuccessBackground : AppColors.successBackground;

  Color get shadowColor =>
      isDark ? AppColors.darkShadowColor : AppColors.shadowColor;
}
