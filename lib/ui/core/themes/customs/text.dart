import 'package:flutter/material.dart';

class TypografyCustomTheme {
  TextTheme textTheme(ColorScheme colorScheme) {
    return TextTheme(
      displayLarge: TextStyle(
        color: colorScheme.onSurface,
      ),
      displayMedium: TextStyle(
        color: colorScheme.onSurface,
      ),
      displaySmall: TextStyle(
        fontWeight: FontWeight.bold,
        color: colorScheme.onSurface,
      ),
      headlineLarge: TextStyle(
        color: colorScheme.onSurface,
      ),
      headlineMedium: TextStyle(
        fontWeight: FontWeight.bold,
        color: colorScheme.onSurface,
      ),
      headlineSmall: TextStyle(
        color: colorScheme.onSurface,
      ),
      titleLarge: TextStyle(
        color: colorScheme.onSurface,
      ),
      titleMedium: TextStyle(
        color: colorScheme.onSurface,
      ),
      titleSmall: TextStyle(
        color: colorScheme.onSurface,
      ),
      bodyLarge: TextStyle(
        color: colorScheme.onSurface,
      ),
      bodyMedium: TextStyle(
        color: colorScheme.onSurface,
      ),
      bodySmall: TextStyle(
        color: colorScheme.onSurface,
      ),
      labelSmall: TextStyle(
        color: colorScheme.onSurface,
      ),
      labelLarge: TextStyle(
        color: colorScheme.onSurface,
      ),
    );
  }

  TextTheme primaryTextTheme(ColorScheme colorScheme) {
    return TextTheme(
      displayLarge: TextStyle(
        color: colorScheme.onPrimary,
      ),
      displayMedium: TextStyle(
        color: colorScheme.onPrimary,
      ),
      displaySmall: TextStyle(
        fontWeight: FontWeight.bold,
        color: colorScheme.onPrimary,
      ),
      headlineLarge: TextStyle(
        color: colorScheme.onPrimary,
      ),
      headlineMedium: TextStyle(
        color: colorScheme.onPrimary,
      ),
      headlineSmall: TextStyle(
        color: colorScheme.onPrimary,
      ),
      titleLarge: TextStyle(
        color: colorScheme.onPrimary,
      ),
      titleMedium: TextStyle(
        color: colorScheme.onPrimary,
      ),
      titleSmall: TextStyle(
        color: colorScheme.onPrimary,
      ),
      bodyLarge: TextStyle(
        color: colorScheme.onPrimary,
      ),
      bodyMedium: TextStyle(
        color: colorScheme.onPrimary,
      ),
      bodySmall: TextStyle(
        color: colorScheme.onPrimary,
      ),
      labelSmall: TextStyle(
        color: colorScheme.onPrimary,
      ),
      labelLarge: TextStyle(
        color: colorScheme.onPrimary,
      ),
    );
  }
}
