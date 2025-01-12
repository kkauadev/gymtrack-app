import 'package:flutter/material.dart';
import 'package:gymtrack/ui/core/themes/colors.dart';
import 'package:gymtrack/ui/core/themes/customs/tab_bar.dart';
import 'package:gymtrack/ui/core/themes/customs/text.dart';
import 'package:gymtrack/ui/core/themes/extensions.dart';

abstract final class AppTheme {
  static const _inputDecorationTheme = InputDecorationTheme(
    hintStyle: TextStyle(
      color: AppColors.grey3,
      fontSize: 18.0,
      fontWeight: FontWeight.w400,
    ),
  );

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: AppColors.lightColorScheme,
    textTheme: TypografyCustomTheme().textTheme(AppColors.lightColorScheme),
    tabBarTheme: TabBarCustomTheme.tabBarTheme(AppColors.lightColorScheme),
    primaryTextTheme: TypografyCustomTheme().primaryTextTheme(
      AppColors.lightColorScheme,
    ),
    inputDecorationTheme: _inputDecorationTheme,
    extensions: [
      AppThemeDimensions(
        padding: AppDimensions(
          extraSmall: 4,
          small: 8,
          medium: 16,
          large: 24,
          extraLarge: 32,
        ),
        margin: AppDimensions(
          extraSmall: 4,
          small: 8,
          medium: 16,
          large: 24,
          extraLarge: 32,
        ),
        borderRadius: AppDimensions(
          extraSmall: 8,
          small: 12,
          medium: 16,
          large: 20,
          extraLarge: 32,
        ),
      ),
    ],
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: AppColors.darkColorScheme,
    textTheme: TypografyCustomTheme().textTheme(AppColors.darkColorScheme),
    tabBarTheme: TabBarCustomTheme.tabBarTheme(AppColors.darkColorScheme),
    primaryTextTheme: TypografyCustomTheme().primaryTextTheme(
      AppColors.lightColorScheme,
    ),
    inputDecorationTheme: _inputDecorationTheme,
    extensions: [
      AppThemeDimensions(
        padding: AppDimensions(
          extraSmall: 4,
          small: 8,
          medium: 16,
          large: 24,
          extraLarge: 32,
        ),
        margin: AppDimensions(
          extraSmall: 4,
          small: 8,
          medium: 16,
          large: 24,
          extraLarge: 32,
        ),
        borderRadius: AppDimensions(
          extraSmall: 2,
          small: 4,
          medium: 8,
          large: 16,
          extraLarge: 32,
        ),
      ),
    ],
  );
}
