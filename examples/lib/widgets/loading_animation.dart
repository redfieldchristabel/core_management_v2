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
    // _controller = SimpleAnimation('animating');
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 150,
        width: 150,
        child: RiveAnimation.asset(
          'assets/rive/loading_v2.riv' ,
          animations:  const ['Loading'],
          controllers: [_controller],
        ),
      ),
    );

    // return RiveAnimation.asset(
    //   'assets/rive/loading.riv',
    //   animations:  const ['animating'],
    //   controllers: [_controller],
    // );
  }
}
