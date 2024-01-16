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
  int scoreLevel1 = 0;
  int scoreLevel2 = 0;
  int scoreLevel3 = 0;
  int scoreLevel4 = 0;
  int maxScoreLevel1 = 0;
  int maxScoreLevel2 = 0;
  int maxScoreLevel3 = 0;
  int maxScoreLevel4 = 0;

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
    if(currentLevelVegetables.isEmpty){
      currentLevelVegetables = vegetablesLevel1;
    }
    return currentLevelVegetables.isNotEmpty ? currentLevelVegetables[currentIndex] : throw Exception("Level is empty");
  }
  //****************************************************************
  // void defineVegetableLevels() {
  //   if(!_isInitialized) {
  //     _isInitialized = true;
  //     shuffledVegetables.shuffle();
  //     int perLevel = 10;
  //     vegetablesLevel1 = shuffledVegetables.take(perLevel).toList();
  //     vegetablesLevel2 = shuffledVegetables.skip(perLevel).take(perLevel).toList();
  //     vegetablesLevel3 = shuffledVegetables.skip(2 * perLevel).take(perLevel).toList();
  //     vegetablesLevel4 = shuffledVegetables.skip(3 * perLevel).take(perLevel).toList();
  //     calculateMaxScorePerLevel();
  //   }
  // }
  //*****************************************************************

  void defineVegetableLevelsNEW() {
    if(!_isInitialized) {
      _isInitialized = true;
      shuffledVegetables.shuffle();
      int perLevel = 8;
      vegetablesLevel1 = shuffledVegetables.take(perLevel).toList();
      vegetablesLevel2 = shuffledVegetables.skip(perLevel).take(perLevel).toList();
      vegetablesLevel3 = shuffledVegetables.skip(2 * perLevel).take(perLevel).toList();
      calculateMaxScorePerLevelNEW();
    }
  }

  //*****************************************************************
  // void calculateMaxScorePerLevel(){
  //   for (Vegetable vegetable in vegetablesLevel1){
  //     maxScoreLevel1 += vegetable.seasons.length * 10;
  //   }
  //   for (Vegetable vegetable in vegetablesLevel2){
  //     maxScoreLevel2 += vegetable.seasons.length * 10;
  //   }
  //   for (Vegetable vegetable in vegetablesLevel3){
  //     maxScoreLevel3 += vegetable.seasons.length * 10;
  //   }
  //   for (Vegetable vegetable in vegetablesLevel4){
  //     maxScoreLevel4 += vegetable.seasons.length * 10;
  //   }
  // }
  //*****************************************************************

  void calculateMaxScorePerLevelNEW(){
    for (Vegetable vegetable in vegetablesLevel1){
      maxScoreLevel1 += vegetable.seasons.length * 10;
    }
    for (Vegetable vegetable in vegetablesLevel2){
      maxScoreLevel2 += vegetable.seasons.length * 10;
    }
    for (Vegetable vegetable in vegetablesLevel3){
      maxScoreLevel3 += vegetable.seasons.length * 10;
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
        switch (currentLevel) {
          case 1:
            scoreLevel1 = score;
            break;
          case 2:
            scoreLevel2 = score;
            break;
          case 3:
            scoreLevel3 = score;
            break;
          case 4:
            scoreLevel4 = score;
            break;
        }
        currentLevel++;
        currentIndex = 0;
        score = 0;


        // ref.read(levelProvider.notifier).state = currentLevel;
        // ref.read(levelCompletedProvider.notifier).state = false;
        ref.read(selectedSeasonsProvider.notifier).state = [];
        ref.read(seasonCheckResultsProvider.notifier).state = {};
        ref.read(seasonPointsProvider.notifier).state = {};
      } else {
        //if all levels finished
        currentLevel++;
        scoreLevel4 = score;
        //ref.read(levelProvider.notifier).state = currentLevel;
        ref.read(levelCompletedProvider.notifier).state = true;

      }
    }
  }

  void infoLevelProvider(WidgetRef ref){
    Future.microtask(() => ref.read(levelProvider.notifier).state = currentLevel);
    Future.microtask(() => ref.read(scoreProvider.notifier).state = 1);
    Future.microtask(() => ref.read(scoreProvider.notifier).state = 0);
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

  void resetGame(WidgetRef ref){
    ref.read(selectedSeasonsProvider.notifier).state = [];
    ref.read(seasonCheckResultsProvider.notifier).state = {};
    ref.read(seasonPointsProvider.notifier).state = {};
    ref.read(levelCompletedProvider.notifier).state = false;
    ref.read(levelProvider.notifier).state = 1;
    ref.read(scoreProvider.notifier).state = 0;
    currentLevel = 1;
    currentIndex = 0;
    score = 0;
    _isInitialized = false;
    vegetablesLevel1 = [];
    vegetablesLevel2 = [];
    vegetablesLevel3 = [];
    vegetablesLevel4 = [];
    scoreLevel1 = 0;
    scoreLevel2 = 0;
    scoreLevel3 = 0;
    scoreLevel4 = 0;
    maxScoreLevel1 = 0;
    maxScoreLevel2 = 0;
    maxScoreLevel3 = 0;
    maxScoreLevel4 = 0;
  }

  String getImageForSeason(Season season) {
    switch (season) {
      case Season.spring:
        return 'assets/app/blossom.png';
      case Season.summer:
        return 'assets/app/sun.png';
      case Season.autumn:
        return 'assets/app/leaf.png';
      case Season.winter:
        return 'assets/app/snowflake.png';
    }
  }

}

