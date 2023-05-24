import 'package:core_management_v2/services/theme_service.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

abstract class BaseFrameworkService {
  ThemeData getThemeData(BaseThemeService themeService) {
    return themeService.createThemeDataByColorSeed();
  }

  GoRouter get goRouterConfig =>
      throw UnimplementedError('Please override getRouterConfig in '
          'framework service if you wat to use this go router');
}
