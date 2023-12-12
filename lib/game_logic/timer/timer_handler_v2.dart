import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/providers.dart';
import '../../shared/constants.dart';
import '../../views/dialogs/level_failed.dart';

class TimerHandlerV2 {
  final Ref ref;
  bool timerStarted= false;
  bool timerExpired= true;

  bool vegetableResult = false;

  TimerHandlerV2(this.ref);

  void handleTimer(BuildContext context, WidgetRef ref) {
    final level = ref.watch(levelProvider);
    final score = ref.watch(scoreProvider);
    final levelCompleted = ref.watch(levelCompletedProvider);
    final timerValue = ref.watch(timerServiceProvider);

    if(level <= 4 && timerValue <= 30 && vegetableResult == false && timerStarted == false){
      _startTimerForLevel(level);
      timerStarted = true;
    }

    if (timerValue == -1) {
      if(timerExpired) {
        _handleTimerExpiration(context, ref, level, score);
        timerExpired = false;
      }
    }

    if(levelCompleted){
      stopTimer();
      }
  }

  void _startTimerForLevel(int level) {
    int seconds = _getSecondsForLevel(level);
    Future.microtask(() => ref.read(timerServiceProvider.notifier).startTimer(seconds));
  }

  int _getSecondsForLevel(int level) {
    switch (level) {
      case 1: return 25;
      case 2: return 20;
      case 3: return 15;
      case 4: return 10;
      default: return 25;
    }
  }

  void _handleTimerExpiration(BuildContext context, WidgetRef ref, int level, int score) {
    //Timer: stop
    stopTimer();
    //Timer: reset
    Future.microtask(() => ref.read(timerServiceProvider.notifier).resetTimer());
    int maxScore = _getMaxScore(level, ref);
    Future.microtask(() => GameDialogLevelFailed.showLevelFailedDialog(context, level, score, maxScore, levelFailedTime,
            (){
          ref.read(timerHandlerProviderV2).timerExpired = true;
          vegetableResult = false;
          timerStarted = false;
        }
    ));
  }

  void stopTimer() {
    //Timer: stop
    ref.read(timerServiceProvider.notifier).stopTimer();
    vegetableResult = true;
  }

  void startTimer(){
    vegetableResult = false;
    timerStarted = false;
  }

  void resetTimer(){
    ref.read(timerServiceProvider.notifier).stopTimer();
    vegetableResult = false;
    timerStarted = false;
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
