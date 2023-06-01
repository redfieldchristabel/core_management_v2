import 'dart:ui';

import 'package:core_management_v2/core_management_v2.dart';
import 'package:flutter/material.dart';

class ThemeService extends BaseThemeService {
  @override
  Color get colorSeed => Colors.purple;

  @override
  AppBarTheme appBarTheme(ThemeData themeData, bool darkMode) {
    return super.appBarTheme(themeData, darkMode);
  }
}
