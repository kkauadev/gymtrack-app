import 'package:flutter/material.dart';

abstract final class AppColors {
  static const black1 = Color(0xFF101010);
  static const white1 = Color(0xFFFFF7FA);
  static const blue1 = Color(0xFF1464F0);
  static const grey1 = Color(0xFFF2F2F2);
  static const grey2 = Color(0xFF4D4D4D);
  static const grey3 = Color(0xFFA4A4A4);
  static const whiteTransparent = Color(0x4DFFFFFF);
  static const blackTransparent = Color(0x4D000000);
  static const red1 = Color(0xFFE74C3C);

  static const lightColorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: Color(0xFF1446c8),
    onPrimary: AppColors.white1,
    //secondary: Color(0xFFFFFFFF),
    secondary: Color.fromRGBO(238, 238, 238, 1),
    onSecondary: AppColors.black1,
    tertiary: Color(0xFF777777),
    onTertiary: AppColors.white1,
    surface: Colors.white,
    onSurface: AppColors.black1,
    error: Colors.red,
    onError: Colors.white,
    errorContainer: Colors.red,
    onErrorContainer: Colors.white,
  );

  static const darkColorScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: AppColors.black1,
    onPrimary: AppColors.white1,
    secondary: AppColors.blue1,
    onSecondary: AppColors.white1,
    surface: AppColors.white1,
    onSurface: Colors.white,
    error: Colors.black,
    onError: AppColors.red1,
  );
}

extension CustomColors on ColorScheme {
  Color get surfaceSecondary => const Color.fromRGBO(251, 65, 65, 1);
  Color get onSurfaceSecondary => const Color.fromRGBO(255, 255, 255, 1);
  Color get surfaceCard => const Color.fromRGBO(65, 200, 65, 1);
  Color get onSurfaceCard => AppColors.white1;
  Color get surfaceCardSecondary => const Color.fromRGBO(200, 65, 65, 1);
  Color get onSurfaceCardSecondary => AppColors.white1;
  Color get warning => const Color.fromRGBO(255, 255, 0, 1);
  Color get onWarning => const Color.fromRGBO(255, 255, 0, 1);
  Color get unselectedLabel => const Color.fromRGBO(20, 100, 240, 0.2);
  Color get inputPrimaryColor => const Color.fromRGBO(238, 238, 238, 1);
  Color get inputSecondaryColor => const Color.fromRGBO(224, 224, 224, 1);
}
