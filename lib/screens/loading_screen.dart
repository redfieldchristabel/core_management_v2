import 'package:core_management_v2/models/controllers/loading_screen.dart';
import 'package:core_management_v2/widgets/loading_animation.dart';
import 'package:flutter/material.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key, this.controller, this.backgroundColor});

  final LoadingScreenController? controller;

  /// the background color of the loading screen
  /// default to theme scaffold background
  /// respect theme color
  final Color? backgroundColor;

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  LoadingScreenController get controller =>
      widget.controller ?? LoadingScreenController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
          animation: controller,
          builder: (context, _) {
            return Column(
              children: <Widget>[
                const LoadingAnimation(),
                if (controller.message != null)
                  Text(
                    controller.message!,
                  ),
              ],
            );
          }),
    );
  }
}

// class LoadingScreen extends StatelessWidget {
//   const LoadingScreen({Key? key, this.message, this.onInit}) : super(key: key);
//
//   final String? message;
//   final void Function(RiveAnimationController controller)? onInit;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: <Widget>[
//           LoadingAnimation(onInit: onInit),
//           Text(
//             message ?? 'Loading...',
//           ),
//         ],
//       ),
//     );
//   }
// }
