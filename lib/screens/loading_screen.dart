import 'package:core_management_v2/widgets/loading_animation.dart';
import 'package:flutter/material.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: <Widget>[
          // Positioned(
          //   top: 350,
          //   left: 125,
          //   child: Text(
          //     'Collecting data...',
          //   ),
          // ),
          LoadingAnimation(),
        ],
      ),
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

