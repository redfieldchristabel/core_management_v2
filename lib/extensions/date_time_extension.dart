import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// Extension method on [DateTime] class to convert date time to
/// localization language using [DateFormat] class from intl package.
extension DateTimeExtension on DateTime {
  //TODO delete this function on december
  @Deprecated("please use 'dateIntlFormat' instead")
  String get intlFormat => dateIntlFormat;

  /// Extension method on [DateTime] class to convert date time to
  /// localization language using [DateFormat] class from intl package.
  String get dateIntlFormat => DateFormat.yMMMEd().format(toLocal());

  @Deprecated("please use 'dateIntlFormat' instead")
  String get intlFormatWithTime => dateItlFormatWithTime;

  /// Extension method on [DateTime] class to convert date time to
  /// localization language using [DateFormat] class from intl package.
  String get dateItlFormatWithTime =>
      "${DateFormat.yMMMEd().format(toLocal())}, ${DateFormat.jm().format(toLocal())}";

  @Deprecated("use timeIntlFormat instead")
  String get timeFormat => DateFormat.jms().format(toLocal());

  /// Format [DateTime] to string using [DateFormat] class from intl package.
  String get timeIntlFormat => DateFormat.jm().format(toLocal());

  /// Format [DateTime] with second to string using [DateFormat] class from intl package.
  String get timeIntlFormatWithSecond => DateFormat.jms().format(toLocal());
}

extension DateTimeTimeofDay on DateTime {
  /// Returns a new [DateTime] instance with the same year, month, and day
  /// as the current instance, but with the hour and minute set to the values
  /// of the specified [TimeOfDay].
  ///
  /// This function does not update the current value, but instead returns a new
  /// instance with the specified time.
  DateTime withTimeOfDay(TimeOfDay timeOfDay) {
    return DateTime(year, month, day, timeOfDay.hour, timeOfDay.minute);
  }
}

extension SecondsSinceMidnight on TimeOfDay {
  /// Returns the number of seconds since midnight.
  int get secondsSinceMidnight => (hour * 60 + minute * 60) * 60;

  /// Create a new [TimeOfDay] instance from the number of seconds since midnight.
  static TimeOfDay fromSecondsSinceMidnight(int seconds) {
    return TimeOfDay(hour: seconds ~/ 3600, minute: (seconds % 3600) ~/ 60);
  }
}
