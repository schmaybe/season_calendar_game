import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TimerService extends StateNotifier<int> {
  Timer? _timer;

  TimerService() : super(30);

  void startTimer(int seconds) {
    state = seconds;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (state > 0) {
        state--;
      } else {
        _timer?.cancel();
        state = -1;
      }
    });
  }

  void stopTimer() {
    _timer?.cancel();
  }

  void resetTimer() {
    state = 30;
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}