import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:season_calendar_game/model/vegetable.dart';
import '../providers/providers.dart';

class VegetableService{
  //Level initalization
  bool _isInitialized = false;
  //level lists
  List<Vegetable> shuffledVegetables = List.from(vegetables);
  List<Vegetable> vegetablesLevel1 = [];
  List<Vegetable> vegetablesLevel2 = [];
  List<Vegetable> vegetablesLevel3 = [];
  List<Vegetable> vegetablesLevel4 = [];
  List<Vegetable> vegetablesLevelTest = [];
  //game vars
  int currentLevel = 1;
  int currentIndex = 0;
  int score = 0;
  //List<Season> selectedSeasons = [];

  //!!!!!!!!
  //Testmode: vegetablesLevelTest
  // Vegetable get currentVegetable => vegetablesLevelTest[currentIndex];
  // void defineTestVegetableLevel(){
  //   if(!_isInitialized){
  //   _isInitialized = true;
  //   List<Vegetable> shuffledVegetables = List.from(vegetables);
  //   shuffledVegetables.shuffle();
  //   vegetablesLevelTest = shuffledVegetables;
  //   }
  // }
  // //!!!!!!!

  //Vegetable get currentVegetable => vegetables[currentIndex];

  Vegetable get currentVegetable {
    List<Vegetable> currentLevelVegetables;
    switch (currentLevel) {
      case 1:
        currentLevelVegetables = vegetablesLevel1;
        break;
      case 2:
        currentLevelVegetables = vegetablesLevel2;
        break;
      case 3:
        currentLevelVegetables = vegetablesLevel3;
        break;
      case 4:
        currentLevelVegetables = vegetablesLevel4;
        break;
      default:
        currentLevelVegetables = [];
    }
    return currentLevelVegetables.isNotEmpty ? currentLevelVegetables[currentIndex] : throw Exception("Level is empty");
  }

  void defineVegetableLevels() {
    if(!_isInitialized) {
      _isInitialized = true;
      shuffledVegetables.shuffle();
      int perLevel = 10;
      vegetablesLevel1 = shuffledVegetables.take(perLevel).toList();
      vegetablesLevel2 = shuffledVegetables.skip(perLevel).take(perLevel).toList();
      vegetablesLevel3 = shuffledVegetables.skip(2 * perLevel).take(perLevel).toList();
      vegetablesLevel4 = shuffledVegetables.skip(3 * perLevel).take(perLevel).toList();
    }
  }

  void toggleSeason(Season season, WidgetRef ref) {
    var selectedSeasonsNotifier = ref.read(selectedSeasonsProvider.notifier);
    List<Season> selectedSeasons = selectedSeasonsNotifier.state;
    if (selectedSeasons.contains(season)) {
      selectedSeasonsNotifier.state = selectedSeasons.where((s) => s != season).toList();
    } else {
      selectedSeasonsNotifier.state = [...selectedSeasons, season];
    }
  }

  // void nextVegetable(WidgetRef ref) {
  //   if (currentIndex < vegetables.length - 1) {
  //     currentIndex++;
  //     ref.read(selectedSeasonsProvider.notifier).state = [];
  //     ref.read(seasonCheckResultsProvider.notifier).state = {};
  //     ref.read(seasonPointsProvider.notifier).state = {};
  //
  //   }
  // }

  void updateSeasonCheckResults(WidgetRef ref) {
    Map<Season, bool> checkResults = {};
    for (var season in Season.values) {
      checkResults[season] = currentVegetable.seasons.contains(season);
    }
    ref.read(seasonCheckResultsProvider.notifier).state = checkResults;
  }


  Map<Season, int> calculateSeasonPoints(WidgetRef ref) {
    var selectedSeasons = ref.read(selectedSeasonsProvider);
    var currentVegetableSeasons = currentVegetable.seasons;
    Map<Season, int> seasonPoints = {};
    for (var season in Season.values) {
      if (currentVegetableSeasons.contains(season)) {
        if (selectedSeasons.contains(season)) {
          seasonPoints[season] = 10; // +10 points correct season
          score += 10;
        } else {
          seasonPoints[season] = -10; // -10 points not selected but correct season
          score -= 10;
        }
      } else {
        if (selectedSeasons.contains(season)) {
          seasonPoints[season] = -15; // -15 points wrong season
          score -= 15;
        }else{
          seasonPoints[season] = 0;   // 0 points season is not selected and not correct
        }
      }
    }
    ref.read(scoreProvider.notifier).state = score;
    return seasonPoints;
  }

  void calculateAndUpdateSeasonPoints(WidgetRef ref) {
    var seasonPoints = calculateSeasonPoints(ref);
    ref.read(seasonPointsProvider.notifier).state = seasonPoints;
  }

  void nextVegetable(WidgetRef ref) {
    List<Vegetable> currentLevelVegetables = [];
    switch (currentLevel) {
      case 1:
        currentLevelVegetables = vegetablesLevel1;
        break;
      case 2:
        currentLevelVegetables = vegetablesLevel2;
        break;
      case 3:
        currentLevelVegetables = vegetablesLevel3;
        break;
      case 4:
        currentLevelVegetables = vegetablesLevel4;
        break;
    }

    if (currentIndex < currentLevelVegetables.length - 1) {
      currentIndex++;
      ref.read(selectedSeasonsProvider.notifier).state = [];
      ref.read(seasonCheckResultsProvider.notifier).state = {};
      ref.read(seasonPointsProvider.notifier).state = {};
    } else {
      // change level
      if (currentLevel < 4) {
        if (isLevelCompleted()) {
          ref.read(levelCompletedProvider.notifier).state = true;
        }
        currentLevel++;
        currentIndex = 0;
        ref.read(levelProvider.notifier).state = currentLevel;
        // ref.read(levelCompletedProvider.notifier).state = false;
        ref.read(selectedSeasonsProvider.notifier).state = [];
        ref.read(seasonCheckResultsProvider.notifier).state = {};
        ref.read(seasonPointsProvider.notifier).state = {};
      } else {
        //if all levels finished
      }
    }
  }

  bool isLevelCompleted() {
    List<Vegetable> currentLevelVegetables = [];
    switch (currentLevel) {
      case 1:
        currentLevelVegetables = vegetablesLevel1;
        break;
      case 2:
        currentLevelVegetables = vegetablesLevel2;
        break;
      case 3:
        currentLevelVegetables = vegetablesLevel3;
        break;
      case 4:
        currentLevelVegetables = vegetablesLevel4;
        break;
    }
    return currentIndex >= currentLevelVegetables.length - 1;
  }









}

