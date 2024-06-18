import 'package:core_management_v2/controllers/loading_animation.dart';
import 'package:core_management_v2/widgets/loading_state_chip.dart';
import 'package:examples/services/framework.dart';
import 'package:flutter/material.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          frameworkService.loadingAnimationController.state = LoadingAnimationState.loading;
          frameworkService.loadingStateChipController
              .animateState(LoadingStateChipValue.uploading);
        },
        child: const Icon(Icons.adb),
      ),
    );
  }
}
