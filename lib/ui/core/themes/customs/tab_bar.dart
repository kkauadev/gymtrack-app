import 'package:flutter/material.dart';
import 'package:gymtrack/ui/core/themes/colors.dart';

class TabBarCustomTheme {
  static TabBarTheme tabBarTheme(ColorScheme colorScheme) {
    return TabBarTheme(
      unselectedLabelColor: colorScheme.unselectedLabel,
      labelColor: colorScheme.secondary,
      labelStyle: TextStyle(fontSize: 18),
      unselectedLabelStyle: TextStyle(fontSize: 18),
      indicatorSize: TabBarIndicatorSize.tab,
      indicatorColor: colorScheme.secondary,
      dividerHeight: 0,
    );
  }
}
