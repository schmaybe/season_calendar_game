import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../game_logic/level_handler.dart';
import '../game_logic/timer/timer_handler.dart';
import '../game_logic/timer/timer_service.dart';
import '../game_logic/vegetable_service.dart';
import '../model/option.dart';
import '../model/vegetable.dart';

final vegetableServiceProvider = Provider<VegetableService>((ref) {
  return VegetableService();
});

final selectedSeasonsProvider = StateProvider<List<Season>>((ref) => []);

final initializationProvider = Provider.autoDispose<void>((ref) {
  ref.read(vegetableServiceProvider).defineVegetableLevelsNEW();          //*******changes cuz NEW 3 times 8 vegetables*******
});

final seasonCheckResultsProvider = StateProvider<Map<Season, bool?>>((ref) => {});

final scoreProvider = StateProvider<int>((ref) => 0);

final levelProvider = StateProvider<int>((ref) => 1);

final seasonPointsProvider = StateProvider<Map<Season, int>>((ref) => {});

final levelCompletedProvider = StateProvider<bool>((ref) => false);
final levelCompletedProvider2 = Provider((ref) => LevelCompletedHandler(ref));

final timerServiceProvider = StateNotifierProvider<TimerService, int>((ref) => TimerService());

final timerHandlerProvider = Provider((ref) => TimerHandler(ref));

final difficultyProvider = StateProvider<Difficulty>((ref) => Difficulty.leicht);

