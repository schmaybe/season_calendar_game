import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/providers.dart';
import '../views/dialogs/level_failed.dart';

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

class TimerHandler {
  final Ref ref;
  int _lastStartedLevel = 0;
  bool timerExpired = true;

  TimerHandler(this.ref);

  void handleTimer(BuildContext context, WidgetRef ref) {
    final level = ref.watch(levelProvider);
    final score = ref.watch(scoreProvider);
    final levelCompleted = ref.watch(levelCompletedProvider);
    final timerValue = ref.watch(timerServiceProvider);

    if(level <= 4 && timerValue <= 30 && _lastStartedLevel != level){
      _lastStartedLevel = level;
      _startTimerForLevel(level);
    }

    if (timerValue == -1) {
      if(timerExpired) {
        _handleTimerExpiration(context, ref, level, score);
        timerExpired = false;
      }
    }

    if (levelCompleted) {
      _handleLevelCompletion(level);
    }
  }

  void _startTimerForLevel(int level) {
    int seconds = _getSecondsForLevel(level);
    Future.microtask(() => ref.read(timerServiceProvider.notifier).startTimer(seconds));
  }

  int _getSecondsForLevel(int level) {
    switch (level) {
      case 1: return 30;
      case 2: return 25;
      case 3: return 20;
      case 4: return 15;
      default: return 30;
    }
  }

  void _handleTimerExpiration(BuildContext context, WidgetRef ref, int level, int score) {
    //Timer: stop
    ref.read(timerServiceProvider.notifier).stopTimer();
    _lastStartedLevel = level;
    //Timer: reset
    Future.microtask(() => ref.read(timerServiceProvider.notifier).resetTimer());
    int maxScore = _getMaxScore(level, ref);
    Future.microtask(() => GameDialogLevelFailed.showLevelFailedDialog(context, level, score, maxScore,
        (){
          ref.read(timerHandlerProvider).timerExpired = true;
        }
    ));
  }

  void _handleLevelCompletion(int level) {
    //Timer: stop
    ref.read(timerServiceProvider.notifier).stopTimer();
  }

  void resetCurrentLvl(){
    _lastStartedLevel = 0;
  }

  int _getMaxScore(int level, WidgetRef ref) {
    final vegetableService = ref.watch(vegetableServiceProvider);
    switch (level) {
      case 1: return vegetableService.maxScoreLevel1;
      case 2: return vegetableService.maxScoreLevel2;
      case 3: return vegetableService.maxScoreLevel3;
      case 4: return vegetableService.maxScoreLevel4;
      default: return 30;
    }
  }
}
