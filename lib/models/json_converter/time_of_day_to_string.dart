import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

class TimeOfDayConverter implements JsonConverter<TimeOfDay, int> {
  final bool isMicroseconds;

  const TimeOfDayConverter({this.isMicroseconds = false});

  @override
  TimeOfDay fromJson(int json) {
    return TimeOfDay.fromDateTime(DateTime.fromMicrosecondsSinceEpoch(
        json * (isMicroseconds ? 1 : 1000)));
  }

  @override
  int toJson(TimeOfDay object) {
    return (object.hour * object.minute) * 60 * (isMicroseconds ? 1000 : 1);
  }
}
