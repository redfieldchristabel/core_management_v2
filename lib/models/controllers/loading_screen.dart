import 'package:flutter/cupertino.dart';

class LoadingScreenController extends ChangeNotifier {
  String? _message;

  String? get message => _message;

  void setMessage(String? message) {
    _message = message;
    notifyListeners();
  }
}
