import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:season_calendar_game/game_logic/vegetable_service.dart';
import '../providers/providers.dart';
import '../views/dialogs/level_completed.dart';

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

        if (level <= 4) {
          Future.microtask(() =>
          ref
              .read(levelCompletedProvider.notifier)
              .state = false);
          Future.microtask(() =>
              GameDialogLevelCompleted.showLevelCompletedDialog(
                context,
                ref,
                score,
                maxScore,
                level,
                    () {
                  ref.read(levelCompletedProvider2).localLevelCompleted = true;
                  vegetableService.infoLevelProvider(ref);
                },
              ));
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