import 'package:core_management_v2/core_management_v2.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class LoadingAnimation extends StatefulWidget {
  const LoadingAnimation({Key? key}) : super(key: key);

  @override
  State<LoadingAnimation> createState() => _LoadingAnimationState();
}

class _LoadingAnimationState extends State<LoadingAnimation> {
  late RiveAnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = SimpleAnimation(BaseFrameworkService
        .instance.defaultLoadingRiveAnimation.initialAnimationName);
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: RiveAnimation.asset(
        BaseFrameworkService.instance.defaultLoadingRiveAnimation.assets,
        animations: const ['animating'],
        controllers: [_controller],
      ),
    );
  }
}
