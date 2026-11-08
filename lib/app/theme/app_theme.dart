import 'package:flutter/material.dart';
import 'package:j_donuts/app/theme/app_colors.dart';
import 'package:j_donuts/app/theme/app_spacing.dart';
import 'package:j_donuts/app/theme/app_typography.dart';

abstract final class AppTheme {
  static ThemeData light() {
    const scheme = ColorScheme.light(
      primary: AppColors.primary,
      secondary: AppColors.accent,
      onSecondary: AppColors.onPrimary,
      tertiary: AppColors.warning,
      onSurface: AppColors.ink,
      onSurfaceVariant: AppColors.inkSecondary,
      error: AppColors.error,
      outline: AppColors.divider,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      fontFamily: AppTypography.fontFamily,
      textTheme: AppTypography.textTheme,
      scaffoldBackgroundColor: AppColors.scaffold,
      splashFactory: InkSparkle.splashFactory,
      dividerColor: AppColors.divider,
      inputDecorationTheme: _inputDecorationTheme,
      filledButtonTheme: _filledButtonTheme,
      snackBarTheme: _snackBarTheme,
      bottomSheetTheme: _bottomSheetTheme,
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.android: FadeForwardsPageTransitionsBuilder(),
        },
      ),
    );
  }

  static InputDecorationTheme get _inputDecorationTheme => InputDecorationTheme(
    filled: true,
    fillColor: AppColors.surface,
    hintStyle: AppTypography.fieldInput.copyWith(color: AppColors.inkTertiary),
    errorStyle: AppTypography.caption.copyWith(color: AppColors.error),
    contentPadding: const EdgeInsets.symmetric(
      horizontal: AppSpacing.xl,
      vertical: AppSpacing.lg,
    ),
    border: _fieldBorder(AppColors.surface),
    enabledBorder: _fieldBorder(AppColors.surface),
    focusedBorder: _fieldBorder(AppColors.primary),
    errorBorder: _fieldBorder(AppColors.error),
    focusedErrorBorder: _fieldBorder(AppColors.error),
  );

  static OutlineInputBorder _fieldBorder(Color color) => OutlineInputBorder(
    borderRadius: BorderRadius.circular(AppRadii.lg),
    borderSide: BorderSide(color: color, width: 1.5),
  );

  static FilledButtonThemeData get _filledButtonTheme => FilledButtonThemeData(
    style: FilledButton.styleFrom(
      backgroundColor: AppColors.primary,
      foregroundColor: AppColors.onPrimary,
      disabledBackgroundColor: AppColors.disabledFill,
      disabledForegroundColor: AppColors.disabledInk,
      minimumSize: const Size.fromHeight(AppSizes.buttonHeight),
      shape: const StadiumBorder(),
      textStyle: AppTypography.button,
    ),
  );

  static SnackBarThemeData get _snackBarTheme => SnackBarThemeData(
    behavior: SnackBarBehavior.floating,
    backgroundColor: AppColors.ink,
    contentTextStyle: AppTypography.bodySmall.copyWith(
      color: AppColors.onPrimary,
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppRadii.md),
    ),
  );

  static BottomSheetThemeData get _bottomSheetTheme =>
      const BottomSheetThemeData(
        backgroundColor: AppColors.surface,
        showDragHandle: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(AppRadii.xl),
          ),
        ),
      );
}
