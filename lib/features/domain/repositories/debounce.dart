import 'dart:async';
import 'package:flutter/foundation.dart';

final debounce = Debounce(const Duration(milliseconds: 500));

class Debounce {
  Debounce(this.delay);

  Duration delay;
  Timer? _timer;

  call(VoidCallback callback) {
    _timer?.cancel();
    _timer = Timer(delay, callback);
  }

  dispose() {
    _timer?.cancel();
  }
}
