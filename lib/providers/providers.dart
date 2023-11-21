import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../game_logic/vegetable_service.dart';
import '../model/vegetable.dart';

final vegetableServiceProvider = Provider<VegetableService>((ref) {
  return VegetableService();
});

final selectedSeasonsProvider = StateProvider<List<Season>>((ref) => []);

final initializationProvider = Provider.autoDispose<void>((ref) {
  ref.read(vegetableServiceProvider).defineVegetableLevels();
});

final seasonCheckResultsProvider = StateProvider<Map<Season, bool?>>((ref) => {});

final scoreProvider = StateProvider<int>((ref) => 0);

final levelProvider = StateProvider<int>((ref) => 1);

final seasonPointsProvider = StateProvider<Map<Season, int>>((ref) => {});

final levelCompletedProvider = StateProvider<bool>((ref) => false);



