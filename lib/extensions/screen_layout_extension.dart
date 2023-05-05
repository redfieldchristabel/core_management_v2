import 'package:flutter/material.dart';

extension ScreenLayoutExtension on BuildContext{
  Size get screenSize {
    return MediaQuery.of(this).size;
  }

  double get shortestSide {
    return MediaQuery.of(this).size.shortestSide;
  }

  ///check if this application run on normal mobile screen size
  bool get mobileLayout {
    return shortestSide < 600;
  }

  ThemeData get themeData {
    return Theme.of(this);
  }
}
