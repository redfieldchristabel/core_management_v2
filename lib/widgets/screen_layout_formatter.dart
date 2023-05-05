import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

/// A widget that formats the child widget based on the screen size.
///
/// It uses [ResponsiveBreakpoints] from [responsive_framework] package to determine
/// the appropriate layout based on the device's screen size.
///
/// The class takes in a [child] parameter of type [Widget], which is the widget
/// that needs to be formatted based on the screen size.
/// This formatter however can be customized according your need.
/// Please refer responsive framework documentation in pub.dev for more information

class ScreenLayoutFormatter extends StatelessWidget {
  const ScreenLayoutFormatter({Key? key,
  required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ResponsiveBreakpoints.builder(
      child: child,
      breakpoints: [
        const Breakpoint(start: 0, end: 450, name: MOBILE),
        const Breakpoint(start: 451, end: 800, name: TABLET),
        const Breakpoint(start: 801, end: 1920, name: DESKTOP),
        const Breakpoint(start: 1921, end: double.infinity, name: '4K'),
      ],
    );
  }
}

