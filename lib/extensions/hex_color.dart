import 'dart:ui';

/// Extension method on the [Color] class to allow creating a [Color] instance
/// from a hex string representation.
extension HexColor on Color {
  /// Creates a [Color] instance from a hex string representation of the color.
  ///
  /// The [hexString] parameter should be in the format "aabbcc" or "ffaabbcc"
  /// with an optional leading "#" character.
  ///
  /// Returns a [Color] instance that corresponds to the hex string.
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  /// Returns a string representation of the [Color] instance as a hex string.
  ///
  /// The [leadingHashSign] parameter controls whether the returned string
  /// includes a leading "#" character (default is `true`).
  ///
  /// The [withOpacityFormat] parameter controls whether the returned string
  /// includes an alpha value (default is `true`). If set to `false`, the
  /// alpha value will not be included in the returned string.
  ///
  /// Returns a string representation of the [Color] instance as a hex string.
  String toHex({bool leadingHashSign = true, bool withOpacityFormat = true}) =>
      '${leadingHashSign ? '#' : ''}'
      '${withOpacityFormat ? alpha.toRadixString(16).padLeft(2, '0') : ""}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
  }

