import 'package:core_management_v2/core_management_v2.dart';
import 'package:flutter/material.dart';

abstract class BaseFrameworkService {
  static BaseFrameworkService? _instance;

  /// Must run this initialize so that core framework can you the same instance as your project
  static initialize(BaseFrameworkService frameworkService) {
    _instance = frameworkService;
  }

  /// Get the same instance as consumer
  static BaseFrameworkService get instance {
    if (_instance == null) {
      throw CoreFrameworkException(
          message: 'instance is not initialized',
          hint: 'call "BaseFrameworkService.initialize()" first');
    }
    return _instance!;
  }

  BaseThemeService get themeService;

  ThemeData get themeData {
    return themeService.createThemeDataByColorSeed();
  }

  /// Override this getter to change the default rive file using in [LoadingAnimation]
  LoadingRiveAnimation get defaultLoadingRiveAnimation => LoadingRiveAnimation(
        assets: 'packages/core_management_v2/assets/rive/loading_v2.riv',
        initialAnimationName: ['Loading'],
      );
}
