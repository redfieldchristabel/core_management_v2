import 'package:core_management_v2/widgets/loading_animation.dart';
import 'package:flutter/material.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({Key? key, this.message}) : super(key: key);

  final String? message;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Text(
            message ?? 'Collecting data...',
          ),
          const LoadingAnimation(),
        ],
      ),
    );
  }
}
