import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

abstract class BaseThemeService {
  Color get colorSeed;

  ///function to create theme data by primary color seed
  ///
  ///[colorSchemeSeed] a color to be base while generation the
  /// whole color pallet use material 3. Will use [colorSeed] if [colorSchemeSeed]
  /// parameter is not given.
  ///
  /// [themeData] a theme data if you want to redefine the whole theme manually.
  /// you can also change the colorSchemeSeed in this ti be use or not.
  /// you can also toggle off [themeData.useMaterial3] that by default this function
  /// will set to true.
  ThemeData createThemeDataByColorSeed([
    Color? colorSchemeSeed,
    ThemeData? themeData,
  ]) {
    final primaryColorSeed = colorSchemeSeed ?? colorSeed;
    final ThemeData innerThemeData = themeData ??
        ThemeData(useMaterial3: true, colorSchemeSeed: primaryColorSeed);
    bool darkMode = innerThemeData.brightness == Brightness.dark;
    bool darkColor = ThemeData.estimateBrightnessForColor(primaryColorSeed) ==
        Brightness.dark;
    if (kDebugMode) {
      print("is dark color: ${darkColor.toString()}");
    }

    return innerThemeData.copyWith(
      useMaterial3: true,
      brightness: innerThemeData.brightness,
      cardTheme: cardTheme(innerThemeData, darkMode),
      elevatedButtonTheme: elevatedButtonTheme(innerThemeData, darkMode),
      iconTheme: iconTheme(innerThemeData),
      appBarTheme: appBarTheme(innerThemeData, darkMode),
      chipTheme: chipThemeData(innerThemeData, darkMode),
      listTileTheme: listTileTheme(innerThemeData),
      bottomSheetTheme: bottomSheetThemeData(innerThemeData, darkMode),
      dividerTheme: dividerTheme(innerThemeData),
      inputDecorationTheme: inputDecorationTheme(innerThemeData, darkMode),
      tabBarTheme: tabBarTheme(innerThemeData, darkMode),
      textTheme: textTheme(innerThemeData, darkMode, darkColor),
      floatingActionButtonTheme: floatingActionButtonTheme(innerThemeData),
    );
  }

  FloatingActionButtonThemeData floatingActionButtonTheme(
          ThemeData innerThemeData) =>
      innerThemeData.floatingActionButtonTheme;

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
  /// ElevatedButtonThemeData myButtonTheme =  elevatedButtonTheme(true);
  /// ```
  ElevatedButtonThemeData elevatedButtonTheme(
      ThemeData themeData, bool darkMode) {
    return themeData.elevatedButtonTheme;
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
  /// AppBarTheme myAppBarTheme =  appBarTheme(myThemeData, true);
  /// ```
  AppBarTheme appBarTheme(ThemeData themeData, bool darkMode) {
    return themeData.appBarTheme;
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
  /// BottomSheetThemeData myBottomSheetTheme =  bottomSheetThemeData(myThemeData, true);
  /// ```
  BottomSheetThemeData bottomSheetThemeData(
    ThemeData themeData,
    bool darkMode,
  ) {
    return themeData.bottomSheetTheme;
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
  /// InputDecorationTheme myInputDecorationTheme =  inputDecorationTheme(myThemeData, true);
  /// ```
  InputDecorationTheme inputDecorationTheme(
    ThemeData themeData,
    bool darkMode,
  ) {
    return themeData.inputDecorationTheme;
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
  /// TabBarTheme myTabBarTheme =  tabBarTheme(myThemeData, true);
  /// ```
  TabBarTheme tabBarTheme(ThemeData themeData, bool darkMode) {
    return themeData.tabBarTheme;
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
  /// ChipThemeData myChipTheme =  chipThemeData(myThemeData, true);
  /// ```
  ChipThemeData chipThemeData(ThemeData themeData, bool darkMode) {
    return themeData.chipTheme;
  }

  TextTheme textTheme(
    ThemeData themeData,
    bool darkMode,
    bool darkColor,
  ) {
    return themeData.textTheme.copyWith(
      displayLarge: displayLarge(themeData, darkMode),
      displayMedium: displayMedium(themeData, darkMode),
      displaySmall: displaySmall(themeData, darkMode),
      headlineMedium: headlineMedium(themeData, darkMode),
      //this is text theme for all title in app bar
      titleLarge: titleLarge(themeData, darkMode),
      //this text theme is for card subtitle
      titleMedium: titleMedium(themeData, darkMode),
      //this text theme is for search bar value
      titleSmall: titleSmall(themeData, darkMode),
      // this text theme is for body with white background in light mode
      // TextField used this style by default
      bodyLarge: bodyLarge(themeData, darkMode),
      // this text theme is for body with white background in light mode
      bodyMedium: bodyMedium(themeData, darkMode),
    );
  }

  TextStyle? bodyMedium(ThemeData themeData, bool darkMode) {
    return themeData.textTheme.bodyMedium;
  }

  TextStyle? bodyLarge(ThemeData themeData, bool darkMode) {
    return themeData.textTheme.bodyLarge;
  }

  TextStyle? titleSmall(ThemeData themeData, bool darkMode) {
    return themeData.textTheme.titleSmall;
  }

  TextStyle? titleMedium(ThemeData themeData, bool darkMode) {
    return themeData.textTheme.titleMedium;
  }

  TextStyle? titleLarge(
    ThemeData themeData,
    bool darkMode,
  ) {
    return themeData.textTheme.titleLarge;
  }

  TextStyle? headlineMedium(ThemeData themeData, bool darkMode) {
    return themeData.textTheme.headlineMedium;
  }

  TextStyle? displaySmall(ThemeData themeData, bool darkMode) {
    return themeData.textTheme.displaySmall;
  }

  TextStyle? displayMedium(ThemeData themeData, bool darkMode) {
    return themeData.textTheme.displayMedium;
  }

  TextStyle? displayLarge(ThemeData themeData, bool darkMode) {
    return themeData.textTheme.displayLarge;
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

  DividerThemeData dividerTheme(ThemeData innerThemeData) =>
      innerThemeData.dividerTheme;

  ListTileThemeData listTileTheme(ThemeData innerThemeData) =>
      innerThemeData.listTileTheme;

  IconThemeData iconTheme(ThemeData innerThemeData) => innerThemeData.iconTheme;
}
