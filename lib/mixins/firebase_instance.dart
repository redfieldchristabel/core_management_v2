import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:isar/isar.dart';
import 'package:json_annotation/json_annotation.dart';

mixin FirebaseInstanceMixin {
  late final DocumentReference _docRef;

  @ignore
  void get checkRef {
    try {
      _docRef.hashCode;
    } catch (e) {
      throw Exception(
          'Please initialize ${super.runtimeType} instance first before call this method');
    }
  }

  @ignore
  @JsonKey(includeFromJson: false, includeToJson: false)
  DocumentReference get docRef {
    checkRef;
    return _docRef;
  }

  set docRef(DocumentReference ref) {
    _docRef = ref;
  }
}
