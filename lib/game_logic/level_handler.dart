import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:season_calendar_game/game_logic/timer/timer_handler_v2.dart';
import 'package:season_calendar_game/game_logic/vegetable_service.dart';
import 'package:season_calendar_game/shared/constants.dart';
import '../providers/providers.dart';
import '../views/dialogs/level_completed.dart';
import '../views/dialogs/level_failed.dart';

class LevelCompletedHandler {
  final Ref ref;
  bool localLevelCompleted = true;

  LevelCompletedHandler(this.ref);

  void handleLevelCompleted(BuildContext context, WidgetRef ref) {

    final levelCompleted = ref.watch(levelCompletedProvider);

    if (localLevelCompleted) {
      if (levelCompleted) {
        localLevelCompleted = false;
        final vegetableService = ref.watch(vegetableServiceProvider);
        final score = ref.watch(scoreProvider);
        final level = ref.watch(levelProvider);

        int maxScore = _getMaxScore(vegetableService, level);

        if(score <= 0){
          Future.microtask(() => GameDialogLevelFailed.showLevelFailedDialog(context, level, score, maxScore, levelFailedScore,
                  (){
                ref.read(timerHandlerProviderV2).timerExpired = true;
                ref.read(timerHandlerProviderV2).startTimer();
                ref.read(levelCompletedProvider2).localLevelCompleted = true;
              }
          ));
        }else {
          if (level <= 4) {
            //Future.microtask(() => ref.read(levelCompletedProvider.notifier).state = false);
            Future.microtask(() =>
                GameDialogLevelCompleted.showLevelCompletedDialog(
                  context,
                  ref,
                  score,
                  maxScore,
                  level,
                      () {
                    ref.read(levelCompletedProvider.notifier).state = false;
                    ref.read(levelCompletedProvider2).localLevelCompleted = true;
                    vegetableService.infoLevelProvider(ref);
                    ref.read(timerHandlerProviderV2).startTimer();
                  },
                ));
          }
        }
      }
    }
  }

  static int _getMaxScore(VegetableService service, int level) {
    switch (level) {
      case 1: return service.maxScoreLevel1;
      case 2: return service.maxScoreLevel2;
      case 3: return service.maxScoreLevel3;
      case 4: return service.maxScoreLevel4;
      default: return 30;
    }
  }
}