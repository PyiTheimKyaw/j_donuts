import 'package:flutter/material.dart';
import 'package:j_donuts/app/theme/app_colors.dart';

abstract final class AppTypography {
  static const String fontFamily = 'Lexend';

  static const TextStyle display = TextStyle(
    fontFamily: fontFamily,
    fontSize: 34,
    height: 1.15,
    fontWeight: FontWeight.w700,
    color: AppColors.ink,
  );

  static const TextStyle headline = TextStyle(
    fontFamily: fontFamily,
    fontSize: 28,
    height: 1.2,
    fontWeight: FontWeight.w700,
    color: AppColors.ink,
  );

  static const TextStyle title = TextStyle(
    fontFamily: fontFamily,
    fontSize: 20,
    height: 1.3,
    fontWeight: FontWeight.w600,
    color: AppColors.ink,
  );

  static const TextStyle subtitle = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    height: 1.35,
    fontWeight: FontWeight.w600,
    color: AppColors.ink,
  );

  static const TextStyle body = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    height: 1.5,
    fontWeight: FontWeight.w400,
    color: AppColors.ink,
  );

  static const TextStyle bodySmall = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    height: 1.45,
    fontWeight: FontWeight.w400,
    color: AppColors.inkSecondary,
  );

  static const TextStyle label = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    height: 1.3,
    fontWeight: FontWeight.w500,
    color: AppColors.ink,
  );

  static const TextStyle caption = TextStyle(
    fontFamily: fontFamily,
    fontSize: 12,
    height: 1.4,
    fontWeight: FontWeight.w400,
    color: AppColors.inkSecondary,
  );

  static const TextStyle button = TextStyle(
    fontFamily: fontFamily,
    fontSize: 15,
    height: 1.2,
    fontWeight: FontWeight.w700,
    letterSpacing: 1.4,
    color: AppColors.onPrimary,
  );

  static const TextStyle fieldInput = TextStyle(
    fontFamily: fontFamily,
    fontSize: 18,
    height: 1.3,
    fontWeight: FontWeight.w400,
    color: AppColors.ink,
  );

  static TextTheme get textTheme => const TextTheme(
    displaySmall: display,
    headlineMedium: headline,
    titleLarge: title,
    titleMedium: subtitle,
    bodyLarge: body,
    bodyMedium: bodySmall,
    labelLarge: label,
    bodySmall: caption,
  );
}
