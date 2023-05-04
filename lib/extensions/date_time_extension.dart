import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  /// convert date time to localization language
  /// using [DateFormat] class from intl package
  String get intlFormat => DateFormat.yMMMEd().format(toLocal());

  String get intlFormatWithTime =>
      "${DateFormat.yMMMEd().format(toLocal())}, ${DateFormat.jm().format(toLocal())}";
}

extension DateTimeTimeofDay on DateTime {
  /// this function will not update current value just return a new instance of [DateTime]
  DateTime withTimeOfDay(TimeOfDay timeOfDay) {
    return DateTime(year, month, day, timeOfDay.hour, timeOfDay.minute);
  }
}
