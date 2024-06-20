import 'dart:async';

import 'package:core_management_v2/core_management_v2.dart';
import 'package:flutter/animation.dart';
import 'package:rive/rive.dart';

import 'theme_service.dart';

class FrameworkService extends BaseFrameworkService {
  StateMachineController? _riveController;

  @override
  BaseThemeService get themeService => ThemeService();

  @override
  LoadingRiveAnimation get defaultLoadingRiveAnimation => LoadingRiveAnimation(
      assets: 'assets/rive/liquid_download.riv', initialAnimationName: []);

  // @override
  // RiveAnimationController get riveAnimationController => StateMachineController(StateMachine())..findInput('Downloading');

  @override
  RiveAnimationController? Function(Artboard p1)?
      get onRiveAnimationLoadingInit => (artBoard) {
            if (artBoard is RuntimeArtboard) {
              var ctrl = StateMachineController.fromArtboard(
                  artBoard, 'State machine 1') as StateMachineController;
              ctrl.isActive = false;
              artBoard.addController(ctrl);

              ctrl.findInput<double>('Progress')?.change(60);
              ctrl.findInput<bool>('Downloading')?.change(true);

              return ctrl;
            }
            return null;
          };

  @override
  Future<void> Function(Artboard, RiveAnimationController?)?
      get onRiveAnimationLoadingComplete => (artBoard, ctrl) async {
            if (ctrl is StateMachineController) {
              final progress = ctrl.findInput<double>('Progress')!;
              while (true) {
                final val = progress.value;
                await Future.delayed(const Duration(milliseconds: 10));
                progress.change(val + 10);
                if (val >= 100) {
                  break;
                }
              }

              await Future.delayed(const Duration(seconds: 2));
              // ctrl.findInput<bool>('Downloading')?.change(false);
            }
          };
// @override
// RiveAnimationController get riveAnimationController => RiveAnimationController;
}

final FrameworkService frameworkService = FrameworkService();
