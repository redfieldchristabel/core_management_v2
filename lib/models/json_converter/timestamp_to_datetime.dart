import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

class TimestampDateTimeConverter implements JsonConverter<DateTime, Timestamp> {
  const TimestampDateTimeConverter();

  @override
  DateTime fromJson(Timestamp json) => json.toDate();

  @override
  Timestamp toJson(DateTime json) => Timestamp.fromDate(json);
}
