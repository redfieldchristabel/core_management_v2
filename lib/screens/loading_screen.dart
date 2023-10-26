import 'package:core_management_v2/widgets/loading_animation.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({Key? key, this.message, this.onInit}) : super(key: key);

  final String? message;
  final void Function(RiveAnimationController controller)? onInit;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          LoadingAnimation(onInit: onInit),
          Text(
            message ?? 'Loading...',
          ),
        ],
      ),
    );
  }
}
