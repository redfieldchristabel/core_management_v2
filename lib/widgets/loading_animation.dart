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
    _controller = SimpleAnimation('Loading');
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 150,
        width: 150,
        child: RiveAnimation.asset(
          BaseFrameworkService.instance.defaultLoadingRiveAnimation.assets,
          animations: BaseFrameworkService
              .instance.defaultLoadingRiveAnimation.initialAnimationName,
          controllers: [_controller],
        ),
      ),
    );
  }
}

// class LoadingAnimation extends StatefulWidget {
//   const LoadingAnimation({Key? key, this.onInit}) : super(key: key);
//
//   final void Function(RiveAnimationController controller)? onInit;
//
//   @override
//   State<LoadingAnimation> createState() => _LoadingAnimationState();
// }
//
// class _LoadingAnimationState extends State<LoadingAnimation> {
//   late RiveAnimationController _controller;
//
//   @override
//   void initState() {
//     super.initState();
//     _controller = SimpleAnimation(BaseFrameworkService
//         .instance.defaultLoadingRiveAnimation.initialAnimationName);
//     widget.onInit?.call(_controller);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//       child: RiveAnimation.asset(
//         BaseFrameworkService.instance.defaultLoadingRiveAnimation.assets,
//         animations: const ['animating'],
//         controllers: [_controller],
//       ),
//     );
//   }
// }
