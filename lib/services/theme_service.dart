import 'package:core_management_v2/core_management_v2.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

abstract class BaseThemeService {
  Color get colorSeed;

  CardTheme cardTheme(ThemeData themeData, bool darkMode) {
    return themeData.cardTheme;
  }

  /// Creates an `ElevatedButtonThemeData` object based on the specified parameters.
  ///
  /// This function takes a boolean parameter `darkMode` to determine the color scheme
  /// of the button. If `darkMode` is `true`, it creates a button theme with dark colors.
  /// Otherwise, it creates a button theme with light colors.
  ///
  /// The `ElevatedButtonThemeData` object represents the visual properties and
  /// behavior of an elevated button when used within a theme.
  ///
  /// The `style` property of the `ElevatedButtonThemeData` is set using
  /// `ElevatedButton.styleFrom`, which allows customizing various visual properties
  /// of the button.
  ///
  /// The properties set by `ElevatedButton.styleFrom` in this function include:
  ///
  /// - `elevation`: The z-coordinate at which to place the button's surface relative
  ///   to its parent.
  ///
  /// - `enableFeedback`: A boolean indicating whether the button should provide
  ///   acoustic and haptic feedback upon interaction.
  ///
  /// - `shadowColor`: The color of the button's shadow.
  ///
  /// - `foregroundColor`: The color used for the button's text and icon.
  ///
  /// - `textStyle`: The style of the button's text.
  ///
  /// - `padding`: The padding around the button's content.
  ///
  /// - `backgroundColor`: The color of the button's background.
  ///
  /// - `shape`: The shape of the button's border.
  ///
  /// The returned `ElevatedButtonThemeData` object encapsulates these properties
  /// and can be used to define the theme of elevated buttons within a theme.
  ///
  /// Example usage:
  /// ```dart
  /// ElevatedButtonThemeData myButtonTheme = _elevatedButtonTheme(true);
  /// ```
  ElevatedButtonThemeData _elevatedButtonTheme(bool darkMode) {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 2,
        enableFeedback: true,
        shadowColor: const Color(0xFF00B6F0),
        foregroundColor: Colors.white,
        textStyle: const TextStyle(color: Color(0xFFFFFFFF)),
        padding: const EdgeInsets.all(15),
        backgroundColor: const Color(0xFF00B6F0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }

  /// Creates an `AppBarTheme` object based on the specified parameters.
  ///
  /// This function takes a `ThemeData` object `themeData` and a boolean parameter
  /// `darkMode` to determine the appearance of the app bar. If `darkMode` is `true`,
  /// it creates an app bar theme with dark colors. Otherwise, it creates an app bar
  /// theme with light colors.
  ///
  /// The `AppBarTheme` object represents the visual properties and behavior of an
  /// app bar when used within a theme.
  ///
  /// The `backgroundColor` property of the `AppBarTheme` is set to a constant color
  /// value `Color(0xFF00B6F0)`, which represents the background color of the app bar.
  ///
  /// The `titleTextStyle` property is set using `themeData.textTheme.titleLarge`, which
  /// represents the text style for the app bar's title. It is derived from the `themeData`
  /// object provided as a parameter.
  ///
  /// The `systemOverlayStyle` property is set to a `SystemUiOverlayStyle` object,
  /// which allows customizing the appearance of system overlays like the status bar
  /// and navigation bar. The `statusBarIconBrightness` property of `SystemUiOverlayStyle`
  /// is set to `Brightness.light` if `darkMode` is `true`, otherwise it is set to
  /// `Brightness.dark`. The `statusBarBrightness` property is set to `themeData.brightness`,
  /// which represents the brightness of the overall app theme. The `systemNavigationBarColor`
  /// property is set to `HexColor.fromHex('#121212')` if `darkMode` is `true`, otherwise
  /// it is set to `Color(0xFFFFFFFF)`.
  ///
  /// The returned `AppBarTheme` object encapsulates these properties and can be used
  /// to define the theme of app bars within a theme.
  ///
  /// Example usage:
  /// ```dart
  /// AppBarTheme myAppBarTheme = _appBarTheme(myThemeData, true);
  /// ```
  AppBarTheme _appBarTheme(ThemeData themeData, bool darkMode) {
    return themeData.appBarTheme.copyWith(
      backgroundColor: const Color(0xFF00B6F0),
      titleTextStyle: themeData.textTheme.titleLarge,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarIconBrightness: darkMode ? Brightness.light : Brightness.dark,
        statusBarBrightness: themeData.brightness,
        systemNavigationBarColor:
            darkMode ? HexColor.fromHex('#121212') : const Color(0xFFFFFFFF),
      ),
    );
  }

  /// Creates a `BottomSheetThemeData` object based on the specified parameters.
  ///
  /// This function takes a `ThemeData` object `themeData` and a boolean parameter
  /// `darkMode` to determine the appearance of the bottom sheet. If `darkMode` is `true`,
  /// it creates a bottom sheet theme with dark colors. Otherwise, it creates a bottom sheet
  /// theme with light colors.
  ///
  /// The `BottomSheetThemeData` object represents the visual properties and behavior of a
  /// bottom sheet when used within a theme.
  ///
  /// The `shape` property of the `BottomSheetThemeData` is set to a constant `RoundedRectangleBorder`
  /// with a vertical `BorderRadius` of `Radius.circular(20)`. This gives the bottom sheet rounded
  /// corners at the top.
  ///
  /// The `clipBehavior` property is set to `Clip.antiAliasWithSaveLayer`, which determines how
  /// the content of the bottom sheet is clipped to its shape. `Clip.antiAliasWithSaveLayer` ensures
  /// that the content is clipped with antialiasing to provide smooth edges.
  ///
  /// The returned `BottomSheetThemeData` object encapsulates these properties and can be used
  /// to define the theme of bottom sheets within a theme.
  ///
  /// Example usage:
  /// ```dart
  /// BottomSheetThemeData myBottomSheetTheme = _bottomSheetThemeData(myThemeData, true);
  /// ```
  BottomSheetThemeData _bottomSheetThemeData(
    ThemeData themeData,
    bool darkMode,
  ) {
    return themeData.bottomSheetTheme.copyWith(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
    );
  }

  /// Creates an `InputDecorationTheme` object based on the specified parameters.
  ///
  /// This function takes a `ThemeData` object `themeData` and a boolean parameter `darkMode`
  /// to determine the appearance of the input decoration. If `darkMode` is `true`, it creates
  /// an input decoration theme with dark colors. Otherwise, it creates an input decoration theme
  /// with light colors.
  ///
  /// The `InputDecorationTheme` object represents the visual properties and behavior of an input
  /// decoration when used within a theme.
  ///
  /// The `contentPadding` property of the `InputDecorationTheme` is set to `EdgeInsets.all(3)`
  /// with a left padding of `9`. This provides padding around the input content.
  ///
  /// The `labelStyle` property is set to a `TextStyle` object with a `fontWeight` of `FontWeight.w600`,
  /// a `fontSize` of `16`, a `letterSpacing` of `0.2`, and a color of `HexColor.fromHex('#B9BABC')`.
  /// This defines the style for the input label text.
  ///
  /// The `helperStyle` property is set to a `TextStyle` object with a `fontWeight` of `FontWeight.bold`,
  /// a `fontSize` of `16`, and a color of `HexColor.fromHex('#B9BABC')`. This defines the style for
  /// the input helper text.
  ///
  /// The `fillColor` property is set to `null` if `darkMode` is `true`, otherwise it is set to
  /// `HexColor.fromHex('#F8FAFB')`. This determines the background color of the input field.
  ///
  /// The `prefixIconColor` and `suffixIconColor` properties are set to `themeData.colorScheme.primary`,
  /// which represents the color of the prefix and suffix icons.
  ///
  /// The `filled` property is set to `true` to enable the input field to be filled with a background color.
  ///
  /// The `border` property is set to a `OutlineInputBorder` object with `BorderSide.none` for the side
  /// and `BorderRadius.circular(13.0)` for all four corners. This defines the border appearance of the
  /// input field.
  ///
  /// The returned `InputDecorationTheme` object encapsulates these properties and can be used to define
  /// the theme of input decorations within a theme.
  ///
  /// Example usage:
  /// ```dart
  /// InputDecorationTheme myInputDecorationTheme = _inputDecorationTheme(myThemeData, true);
  /// ```
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

  /// Creates a `TabBarTheme` object based on the specified parameters.
  ///
  /// This function takes a `ThemeData` object `themeData` and a boolean parameter `darkMode`
  /// to determine the appearance of the tab bar. If `darkMode` is `true`, it creates a tab bar
  /// theme with dark colors. Otherwise, it creates a tab bar theme with light colors.
  ///
  /// The `TabBarTheme` object represents the visual properties and behavior of a tab bar when used
  /// within a theme.
  ///
  /// The `labelColor` property of the `TabBarTheme` is set to `Color(0xFF3A5160)`, which represents
  /// the color of the selected tab label.
  ///
  /// The `unselectedLabelColor` property is set to `Colors.white70`, which represents the color of
  /// the unselected tab labels.
  ///
  /// The `labelStyle` property is set to a `TextStyle` object with a `fontWeight` of `FontWeight.w400`,
  /// which defines the style for the selected tab label text.
  ///
  /// The `unselectedLabelStyle` property is set to a `TextStyle` object with a `fontStyle` of `FontStyle.italic`,
  /// which defines the style for the unselected tab label text.
  ///
  /// The `overlayColor` property is set to a `MaterialStateColor` object that resolves the overlay color
  /// based on the current material state. If the state contains `MaterialState.pressed`, the overlay color
  /// is `Colors.blue`. If the state contains `MaterialState.focused`, the overlay color is `Colors.orange`.
  /// If the state contains `MaterialState.hovered`, the overlay color is `Color(0xFF00B6F0)`. For any other
  /// state, the overlay color is `Colors.transparent`.
  ///
  /// The `indicator` property is set to a `BoxDecoration` object that defines the appearance of the tab bar's
  /// indicator. It has a background color of `HexColor.fromHex('#F8FAFB')`, a border with color `Colors.white`,
  /// and a `BorderRadius` of `BorderRadius.all(Radius.circular(16.0))`.
  ///
  /// The `indicatorSize` property is set to `TabBarIndicatorSize.tab`, which indicates that the indicator's
  /// size should be based on the tab's dimensions.
  ///
  /// The returned `TabBarTheme` object encapsulates these properties and can be used to define the theme of
  /// tab bars within a theme.
  ///
  /// Example usage:
  /// ```dart
  /// TabBarTheme myTabBarTheme = _tabBarTheme(myThemeData, true);
  /// ```
  TabBarTheme _tabBarTheme(ThemeData themeData, bool darkMode) {
    return themeData.tabBarTheme.copyWith(
      labelColor: const Color(0xFF3A5160),
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
          return const Color(0xFF00B6F0);
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

  /// Creates a `ChipThemeData` object based on the specified parameters.
  ///
  /// This function takes a `ThemeData` object `themeData` and a boolean parameter `darkMode`
  /// to determine the appearance of the chips. If `darkMode` is `true`, it creates a chip theme
  /// with dark colors. Otherwise, it creates a chip theme with light colors.
  ///
  /// The `ChipThemeData` object represents the visual properties and behavior of chips when used
  /// within a theme.
  ///
  /// The `backgroundColor` property of the `ChipThemeData` is set to the result of `ElevationOverlay.applySurfaceTint`
  /// method. It applies a surface tint to the background color based on the surface color and the specified
  /// elevation value. The background color is `darkMode ? HexColor.fromHex('#121212') : Color(0xFFFFFFFF)`
  /// and the surface color is `Colors.white`. The elevation value is `2`.
  ///
  /// The `side` property is set to a `BorderSide` object with a color of `Color(0xFFEDF0F2)`, which
  /// defines the color of the chip's side border.
  ///
  /// The `padding` property is set to `EdgeInsets.all(5)`, which defines the padding around the chip's content.
  ///
  /// The `shadowColor` property is set to `Colors.black`, which defines the color of the chip's shadow.
  ///
  /// The `elevation` property is set to `5`, which determines the elevation of the chip.
  ///
  /// The `labelStyle` property is set to a `TextStyle` object with a `fontSize` of `10`, a color of
  /// `Color(0xFF00B6F0)`, and a `fontWeight` of `FontWeight.w500`. This defines the style for the chip's label text.
  ///
  /// The returned `ChipThemeData` object encapsulates these properties and can be used to define the theme of
  /// chips within a theme.
  ///
  /// Example usage:
  /// ```dart
  /// ChipThemeData myChipTheme = _chipThemeData(myThemeData, true);
  /// ```
  ChipThemeData _chipThemeData(ThemeData themeData, bool darkMode) {
    return themeData.chipTheme.copyWith(
      backgroundColor: ElevationOverlay.applySurfaceTint(
        darkMode ? HexColor.fromHex('#121212') : const Color(0xFFFFFFFF),
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
      color: darkMode ? Colors.white : const Color(0xFF17262A),
      fontSize: 12,
      // fontFamily: "OpenSansBold",
    );
  }

  TextStyle _titleSmall(ThemeData themeData) {
    return themeData.textTheme.titleSmall!.copyWith(
      fontWeight: FontWeight.w600,
      fontSize: 18,
      letterSpacing: 0.27,
      color: const Color(0xFF00B6F0),
    );
  }

  TextStyle _titleMedium(ThemeData themeData, bool darkMode) {
    return themeData.textTheme.titleMedium!.copyWith(
      color: darkMode ? const Color(0xFFFFFFFF) : const Color(0xFF3A5160),
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
      color: darkMode ? const Color(0xFFFFFFFF) : Colors.black,
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
      color: darkMode ? HexColor.fromHex('#B9BABC') : const Color(0xFF17262A),
    );
  }

  TextStyle? _displayMedium(ThemeData themeData, bool darkMode) {
    return themeData.textTheme.displayMedium?.copyWith(
      fontWeight: FontWeight.w400,
      fontSize: 14,
      letterSpacing: 0.2,
      color: darkMode ? const Color(0xFFFEFEFE) : const Color(0xFF3A5160),
    );
  }

  TextStyle? _displayLarge(ThemeData themeData, bool darkMode) {
    return themeData.textTheme.displayLarge?.copyWith(
      fontWeight: FontWeight.w700,
      fontSize: 22,
      letterSpacing: 0.27,
      color: darkMode ? const Color(0xFFFFFFFF) : const Color(0xFF253840),
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
      cardTheme: cardTheme(themeData, darkMode),
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
        iconColor: darkMode ? const Color(0xFFFEFEFE) : const Color(0xFF00B6F0),
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
