import 'package:core_management_v2/services/theme_service.dart';
import 'package:flutter/material.dart';

abstract class BaseFrameworkService {
  ThemeData getThemeData(BaseThemeService themeService) {
    return themeService.createThemeDataByPrimaryColour(
        ThemeData(), themeService.colorSeed);
  }
}
