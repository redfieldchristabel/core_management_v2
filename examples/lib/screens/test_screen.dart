import 'package:core_management_v2/controllers/loading_animation.dart';
import 'package:core_management_v2/core_management_v2.dart';
import 'package:core_management_v2/widgets/loading_state_chip.dart';
import 'package:examples/services/framework.dart';
import 'package:flutter/material.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({super.key});

  LoadingAnimationController get controller =>
      frameworkService.loadingAnimationController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: LoadingAnimation(
      //   stateMachines: ['Downloading'],
      // ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.state = LoadingAnimationState.loading;
          Future.delayed(Duration(seconds: 2), () {
            controller.state = LoadingAnimationState.completed;
                                                       });

          frameworkService.loadingStateChipController
              .animateState(LoadingStateChipValue.uploading);
        },
        child: const Icon(Icons.adb),
      ),
    );
  }
}
