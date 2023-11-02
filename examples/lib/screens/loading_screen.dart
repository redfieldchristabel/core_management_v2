import 'package:core_management_v2/core_management_v2.dart';
import 'package:flutter/material.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        // mainAxisAlignment: MainAxisAlignment.center,
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
