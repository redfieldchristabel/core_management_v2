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
          frameworkService.loadingStateChipController
              .animateState(LoadingStateChipValue.uploading);
        },
        child: const Icon(Icons.adb),
      ),
    );
  }
}
