

import 'package:core_management_v2/core_management_v2.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ThemeService {
  CardTheme _cardTheme(ThemeData themeData, bool darkMode) {
    return themeData.cardTheme.copyWith(
      color: darkMode
          ? ElevationOverlay.applySurfaceTint(
        HexColor.fromHex('#121212'),
        Colors.white,
        1,
      )
          : HexColor.fromHex('#F8FAFB'),
    );
  }

  ElevatedButtonThemeData _elevatedButtonTheme(bool darkMode) {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 2,
        enableFeedback: true,
        shadowColor: Color(0xFF00B6F0),
        foregroundColor: Colors.white,
        textStyle: const TextStyle(color: Color(0xFFFFFFFF)),
        padding: const EdgeInsets.all(15),
        backgroundColor: Color(0xFF00B6F0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }

  AppBarTheme _appBarTheme(ThemeData themeData, bool darkMode) {
    return themeData.appBarTheme.copyWith(
      backgroundColor: Color(0xFF00B6F0),
      titleTextStyle: themeData.textTheme.titleLarge,
      systemOverlayStyle: SystemUiOverlayStyle(
        // systemStatusBarContrastEnforced: true,
        statusBarIconBrightness: darkMode ? Brightness.light : Brightness.dark,
        statusBarBrightness: themeData.brightness,
        systemNavigationBarColor:
        darkMode ? HexColor.fromHex('#121212') : Color(0xFFFFFFFF),
      ),
    );
  }

  BottomSheetThemeData _bottomSheetThemeData(
      ThemeData themeData,
      bool darkMode,
      ) {
    return themeData.bottomSheetTheme.copyWith(
      // transitionAnimationController: AnimationController(
      //   vsync: this,
      //   duration: Duration(milliseconds: 400),
      // ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
    );
  }

  InputDecorationTheme _inputDecorationTheme(
      ThemeData themeData,
      bool darkMode,
      ) {
    return themeData.inputDecorationTheme.copyWith(
      contentPadding: const EdgeInsets.all(3).copyWith(left: 9),
      labelStyle: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 16,
        letterSpacing: 0.2,
        color: HexColor.fromHex('#B9BABC'),
      ),
      helperStyle: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 16,
        color: HexColor.fromHex('#B9BABC'),
      ),
      fillColor: darkMode ? null : HexColor.fromHex('#F8FAFB'),
      // fillColor: HexColor.fromHex('#1F1B24'),
      prefixIconColor: themeData.colorScheme.primary,
      suffixIconColor: themeData.colorScheme.primary,
      filled: true,
      border: const OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(13.0),
          bottomLeft: Radius.circular(13.0),
          topLeft: Radius.circular(13.0),
          topRight: Radius.circular(13.0),
        ),
      ),
    );
  }

  TabBarTheme _tabBarTheme(ThemeData themeData, bool darkMode) {
    return themeData.tabBarTheme.copyWith(
      labelColor: Color(0xFF3A5160),
      unselectedLabelColor: Colors.white70,
      labelStyle: const TextStyle(fontWeight: FontWeight.w400),
      unselectedLabelStyle: const TextStyle(fontStyle: FontStyle.italic),
      overlayColor: MaterialStateColor.resolveWith((Set<MaterialState> states) {
        if (states.contains(MaterialState.pressed)) {
          return Colors.blue;
        }
        if (states.contains(MaterialState.focused)) {
          return Colors.orange;
        } else if (states.contains(MaterialState.hovered)) {
          return Color(0xFF00B6F0);
        }

        return Colors.transparent;
      }),
      indicator: BoxDecoration(
        color: HexColor.fromHex('#F8FAFB'),
        borderRadius: const BorderRadius.all(Radius.circular(16.0)),
        border: Border.all(color: Colors.white),
        // borderRadius: BorderRadius.circular(13),
        // color: SpupcAppTheme.nearlyWhite,
      ),
      indicatorSize: TabBarIndicatorSize.tab,
    );
  }

  ChipThemeData _chipThemeData(ThemeData themeData, bool darkMode) {
    return themeData.chipTheme.copyWith(
      backgroundColor: ElevationOverlay.applySurfaceTint(
        darkMode ? HexColor.fromHex('#121212') : Color(0xFFFFFFFF),
        Colors.white,
        2,
      ),
      side: const BorderSide(color: Color(0xFFEDF0F2)),
      padding: const EdgeInsets.all(5),
      shadowColor: Colors.black,
      elevation: 5,
      labelStyle: const TextStyle(
        fontSize: 10,
        color: Color(0xFF00B6F0),
        fontWeight: FontWeight.w500,
      ),
    );
  }

  TextTheme _textTheme(
      ThemeData themeData,
      Color primaryColor,
      bool darkMode,
      bool darkColor,
      ) {
    return themeData.textTheme.copyWith(
      displayLarge: _displayLarge(themeData, darkMode),
      displayMedium: _displayMedium(themeData, darkMode),
      displaySmall: _displaySmall(themeData, darkMode),
      headlineMedium: _headlineMedium(themeData, darkMode),
      //this is text theme for all title in app bar
      titleLarge: _titleLarge(themeData, darkMode),
      //this text theme is for card subtitle
      titleMedium: _titleMedium(themeData, darkMode),
      //this text theme is for search bar value
      titleSmall: _titleSmall(themeData),
      // this text theme is for body with white background in light mode
      // TextField used this style by default
      bodyLarge: _bodyLarge(themeData, darkMode),
      // this text theme is for body with white background in light mode
      bodyMedium: _bodyMedium(themeData, darkMode),
    );
  }

  TextStyle _bodyMedium(ThemeData themeData, bool darkMode) {
    return themeData.textTheme.bodyMedium!.copyWith(
      color: darkMode ? Colors.white : Colors.black,
      fontSize: 16,
      // fontFamily: "GothicA1",
      // fontFamily: "GothicA1",
    );
  }

  TextStyle _bodyLarge(ThemeData themeData, bool darkMode) {
    return themeData.textTheme.bodyLarge!.copyWith(
      color: darkMode ? Colors.white : Color(0xFF17262A),
      fontSize: 12,
      // fontFamily: "OpenSansBold",
    );
  }

  TextStyle _titleSmall(ThemeData themeData) {
    return themeData.textTheme.titleSmall!.copyWith(
      fontWeight: FontWeight.w600,
      fontSize: 18,
      letterSpacing: 0.27,
      color: Color(0xFF00B6F0),
    );
  }

  TextStyle _titleMedium(ThemeData themeData, bool darkMode) {
    return themeData.textTheme.titleMedium!.copyWith(
      color: darkMode ? Color(0xFFFFFFFF) : Color(0xFF3A5160),
      fontWeight: FontWeight.w200,
      fontSize: 12,
      letterSpacing: 0.21,
      // color: SpupcAppTheme.grey,
    );
  }

  TextStyle _titleLarge(
      ThemeData themeData,
      bool darkMode,
      ) {
    return themeData.textTheme.titleLarge!.copyWith(
      color: darkMode ? Color(0xFFFFFFFF) : Colors.black,
      // fontFamily: "OpenSansBold",
    );
  }

  TextStyle _headlineMedium(ThemeData themeData, bool darkMode) {
    return themeData.textTheme.headlineMedium!.copyWith(
      color: darkMode ? Colors.white : Colors.black,
      fontSize: 18,
      fontFamily: "GothicA1",
      fontWeight: FontWeight.bold,
    );
  }

  TextStyle? _displaySmall(ThemeData themeData, bool darkMode) {
    return themeData.textTheme.displaySmall?.copyWith(
      fontWeight: FontWeight.w600,
      fontSize: 16,
      letterSpacing: 0.27,
      color: darkMode ? HexColor.fromHex('#B9BABC') : Color(0xFF17262A),
    );
  }

  TextStyle? _displayMedium(ThemeData themeData, bool darkMode) {
    return themeData.textTheme.displayMedium?.copyWith(
      fontWeight: FontWeight.w400,
      fontSize: 14,
      letterSpacing: 0.2,
      color: darkMode ? Color(0xFFFEFEFE) : Color(0xFF3A5160),
    );
  }

  TextStyle? _displayLarge(ThemeData themeData, bool darkMode) {
    return themeData.textTheme.displayLarge?.copyWith(
      fontWeight: FontWeight.w700,
      fontSize: 22,
      letterSpacing: 0.27,
      color: darkMode ? const Color(0xFFFFFFFF) : Color(0xFF253840),
    );
  }

  //theme end here

  ///use this to make all shoe modal bottom sheet use global animation
  AnimationController showModalBottomSheetAnim(TickerProvider tickerProvider) {
    return AnimationController(
      vsync: tickerProvider,
      duration: const Duration(milliseconds: 400),
    );
  }

  /// amount range from 0.0 to 1.0
  Color lighten(Color color, [double amount = .1]) {
    assert(amount >= 0 && amount <= 1);

    final hsl = HSLColor.fromColor(color);
    final hslLight =
    hsl.withLightness((hsl.lightness + amount).clamp(0.0, 1.0));

    return hslLight.toColor();
  }

  ///function to create theme data by primary color
  ThemeData createThemeDataByPrimaryColour(
      ThemeData themeData,
      Color primaryColor,
      ) {
    bool darkMode = themeData.brightness == Brightness.dark;
    bool darkColor =
        ThemeData.estimateBrightnessForColor(primaryColor) == Brightness.dark;
    if (kDebugMode) {
      print("is dark color: ${darkColor.toString()}");
    }

    return themeData.copyWith(
      useMaterial3: true,
      primaryColor: const Color(0xFF00B6F0),
      brightness: themeData.brightness,
      // colorScheme: ColorScheme(background: lighten(primaryColor, .49)),
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF00B6F0),
        brightness: themeData.brightness,
        primaryContainer: const Color(0xFF00B6F0),
      ),
      cardColor: lighten(primaryColor, .13),
      cardTheme: _cardTheme(themeData, darkMode),
      elevatedButtonTheme: _elevatedButtonTheme(darkMode),
      iconTheme: themeData.iconTheme.copyWith(
        color: darkMode ? const Color(0xFF253840) : const Color(0xFFFEFEFE),
      ),
      scaffoldBackgroundColor:
      darkMode ? HexColor.fromHex('#121212') : const Color(0xFFFEFEFE),
      shadowColor: HexColor.fromHex('#121212').withOpacity(0.2),
      appBarTheme: _appBarTheme(themeData, darkMode),
      chipTheme: _chipThemeData(themeData, darkMode),
      listTileTheme: themeData.listTileTheme.copyWith(
        iconColor:
        darkMode ? const Color(0xFFFEFEFE) : const Color(0xFF00B6F0),
      ),
      bottomSheetTheme: _bottomSheetThemeData(themeData, darkMode),
      dividerTheme: DividerThemeData(
        space: 1,
        color: const Color(0xFF3A5160).withOpacity(0.6),
      ),
      indicatorColor: Colors.red,
      inputDecorationTheme: _inputDecorationTheme(themeData, darkMode),
      tabBarTheme: _tabBarTheme(themeData, darkMode),
      // typography: Typography.material2021(),
      textTheme: _textTheme(themeData, primaryColor, darkMode, darkColor),
    );
  }

}