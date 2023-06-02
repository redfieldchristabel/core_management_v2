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

  String get timeFormat => DateFormat.jms().format(toLocal());
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
