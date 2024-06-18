import 'package:core_management_v2/controllers/loading_animation.dart';
import 'package:core_management_v2/core_management_v2.dart';
import 'package:core_management_v2/widgets/loading_state_chip.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

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

  LoadingStateChipController? _loadingStateChipController;

  LoadingAnimationController? _loadingAnimationController;
  RiveAnimationController? _riveAnimationController;

  initializeLoadingController({
    LoadingStateChipController? chipController,
    LoadingAnimationController? animationController,
    RiveAnimationController? riveAnimationController,
  }) {
    _loadingStateChipController = chipController ?? _loadingStateChipController;
    _loadingAnimationController =
        animationController ?? _loadingAnimationController;
    _riveAnimationController =
        riveAnimationController ?? _riveAnimationController;
    print("init laoding ${_loadingAnimationController == null}");
    print("init laoding ${loadingAnimationController.state}");
  }

  LoadingStateChipController get loadingStateChipController {
    if (_loadingStateChipController == null) {
      throw Exception('LoadingStateChipController is not initialized');
    }
    return _loadingStateChipController!;
  }

  LoadingAnimationController get loadingAnimationController {
    if (_loadingAnimationController == null) {
      throw Exception('LoadingStateChipController is not initialized');
    }
    return _loadingAnimationController!;
  }

  RiveAnimationController get riveAnimationController {
    if (_riveAnimationController == null) {
      throw Exception('RiveAnimationController is not initialized');
    }
    return _riveAnimationController!;
  }
}
