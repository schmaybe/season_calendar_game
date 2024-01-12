import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:season_calendar_game/model/option.dart';
import '../../providers/providers.dart';
import '../../shared/constants.dart';
import '../../views/dialogs/level_failed.dart';
import '../../views/dialogs/show_result.dart';

class TimerHandler {
  final Ref ref;
  bool timerStarted= false;
  bool timerExpired= true;

  bool vegetableResult = false;

  TimerHandler(this.ref);

  void handleTimer(BuildContext context, WidgetRef ref) {
    final level = ref.watch(levelProvider);
    final score = ref.watch(scoreProvider);
    final levelCompleted = ref.watch(levelCompletedProvider);
    final timerValue = ref.watch(timerServiceProvider);
    final dif = ref.watch(difficultyProvider);

    if(level <= 4 && timerValue <= 30 && vegetableResult == false && timerStarted == false){
      _startTimerForLevel(level, dif);
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

  void _startTimerForLevel(int level, var dif) {
    int seconds = _getSecondsForLevel(level, dif);
    Future.microtask(() => ref.read(timerServiceProvider.notifier).startTimer(seconds));
  }

  int _getSecondsForLevel(int level, var dif) {
    int secStart = _getSecondsForDifficulty(dif);
    switch (level) {
      case 1: return secStart;
      case 2: return secStart-5;
      case 3: return secStart-10;
      case 4: return secStart-15;
      default: return 25;
    }
  }

  int _getSecondsForDifficulty(var dif){
    switch (dif){
      case Difficulty.leicht: return 20;
      case Difficulty.mittel: return 25;
      case Difficulty.schwer: return 20;
      default: return 35;
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
          ref.read(timerHandlerProvider).timerExpired = true;
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
