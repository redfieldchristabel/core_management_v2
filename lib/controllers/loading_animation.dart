import 'dart:async';

import 'package:flutter/foundation.dart';

class LoadingAnimationController extends ChangeNotifier {
  LoadingAnimationState _loadingState = LoadingAnimationState.idle;
  Timer? _timer;

  String _value = "";

  /// update this variable to control the state
  LoadingAnimationState get state => _loadingState;

  set state(LoadingAnimationState value) {
    _loadingState = value;
    notifyListeners();
  }

  set value(String value) {
    _value = value;
    notifyListeners();
  }

  String get value => _value;

  void animateState(LoadingAnimationState state,
      {Duration? duration, String value = ""}) {
    _loadingState = state;
    _value = value;
    notifyListeners();

    if (_timer?.isActive ?? false) _timer?.cancel();
    _timer = Timer(
      duration ?? const Duration(seconds: 3),
      () {
        _loadingState = LoadingAnimationState.idle;
        notifyListeners();
      },
    );
  }
}

enum LoadingAnimationState { idle, loading }
