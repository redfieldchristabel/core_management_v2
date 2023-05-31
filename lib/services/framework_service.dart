import 'package:core_management_v2/services/theme_service.dart';
import 'package:flutter/material.dart';

abstract class BaseFrameworkService {
  BaseThemeService get themeService;

  ThemeData getThemeData() {
    return themeService.createThemeDataByColorSeed();
  }
}
