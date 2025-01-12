import 'dart:ui';

import 'package:flutter/material.dart';

class AppDimensions {
  final double extraSmall;
  final double small;
  final double medium;
  final double large;
  final double extraLarge;

  const AppDimensions({
    required this.extraSmall,
    required this.small,
    required this.medium,
    required this.large,
    required this.extraLarge,
  });
}

class AppThemeDimensions extends ThemeExtension<AppThemeDimensions> {
  final AppDimensions padding;
  final AppDimensions margin;
  final AppDimensions borderRadius;

  const AppThemeDimensions({
    required this.padding,
    required this.margin,
    required this.borderRadius,
  });

  @override
  AppThemeDimensions copyWith({
    AppDimensions? padding,
    AppDimensions? margin,
    AppDimensions? borderRadius,
  }) {
    return AppThemeDimensions(
      padding: padding ?? this.padding,
      margin: margin ?? this.margin,
      borderRadius: borderRadius ?? this.borderRadius,
    );
  }

  @override
  AppThemeDimensions lerp(ThemeExtension<AppThemeDimensions>? other, double t) {
    if (other is! AppThemeDimensions) return this;
    return AppThemeDimensions(
      padding: AppDimensions(
        extraSmall:
            lerpDouble(padding.extraSmall, other.padding.extraSmall, t)!,
        small: lerpDouble(padding.small, other.padding.small, t)!,
        medium: lerpDouble(padding.medium, other.padding.medium, t)!,
        large: lerpDouble(padding.large, other.padding.large, t)!,
        extraLarge:
            lerpDouble(padding.extraLarge, other.padding.extraLarge, t)!,
      ),
      margin: AppDimensions(
        extraSmall: lerpDouble(margin.extraSmall, other.margin.extraSmall, t)!,
        small: lerpDouble(margin.small, other.margin.small, t)!,
        medium: lerpDouble(margin.medium, other.margin.medium, t)!,
        large: lerpDouble(margin.large, other.margin.large, t)!,
        extraLarge: lerpDouble(margin.extraLarge, other.margin.extraLarge, t)!,
      ),
      borderRadius: AppDimensions(
        extraSmall: lerpDouble(
            borderRadius.extraSmall, other.borderRadius.extraSmall, t)!,
        small: lerpDouble(borderRadius.small, other.borderRadius.small, t)!,
        medium: lerpDouble(borderRadius.medium, other.borderRadius.medium, t)!,
        large: lerpDouble(borderRadius.large, other.borderRadius.large, t)!,
        extraLarge: lerpDouble(
            borderRadius.extraLarge, other.borderRadius.extraLarge, t)!,
      ),
    );
  }
}
