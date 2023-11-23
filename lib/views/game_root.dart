import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../custom_widgets/score.dart';
import '../model/vegetable.dart';
import '../providers/providers.dart';
import 'game_dialogs.dart';

class GameRoot extends ConsumerWidget {
  const GameRoot({super.key});


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.read(initializationProvider);
    final selectedSeasons = ref.watch(selectedSeasonsProvider);
    final vegetableService = ref.watch(vegetableServiceProvider);
    final seasonCheckResults = ref.watch(seasonCheckResultsProvider);
    final score = ref.watch(scoreProvider);
    final level = ref.watch(levelProvider);
    final seasonPoints = ref.watch(seasonPointsProvider);
    final levelCompleted = ref.watch(levelCompletedProvider);

    if (levelCompleted) {
      int maxScore = 0;
      switch (level) {
        case 1:
          maxScore = vegetableService.maxScoreLevel1;
          break;
        case 2:
          maxScore = vegetableService.maxScoreLevel2;
          break;
        case 3:
          maxScore = vegetableService.maxScoreLevel3;
          break;
        case 4:
          maxScore = vegetableService.maxScoreLevel4;
          break;
      }
      Future.microtask(() => GameDialogs.showLevelCompletedDialog(
          context,
          score,
          maxScore,
          level,
              () {
            ref.read(levelCompletedProvider.notifier).state = false;
            vegetableService.infoLevelProvider(ref);
          },
        )
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: Text("Score: $score               Level: $level"),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: const AssetImage("assets/app/wheat.jpg"),
            colorFilter: ColorFilter.mode(
              Colors.grey.withOpacity(0.3),
              BlendMode.darken,
            ),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
                child: SizedBox(
                  width: 500,
                  height: 350,
                  child: Image.asset(vegetableService.currentVegetable.imgPath),
                ),
            ),
            Text(
                style: const TextStyle(
                  fontSize: 25,
                  letterSpacing: 1.5,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
                vegetableService.currentVegetable.name

            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: Season.values.map((season) {
                Color buttonColor = selectedSeasons.contains(season) ? Colors.green : Colors.grey;
                if (seasonCheckResults.isNotEmpty) {
                  buttonColor = seasonCheckResults[season]! ? Colors.green : Colors.grey;
                }
                return Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Column(
                    children: [
                      if (seasonPoints.containsKey(season))
                        buildSeasonScoreIndicator(seasonPoints[season]!),
                      SizedBox(
                        width: 70,
                        height: 100,
                        child: FloatingActionButton(
                          onPressed: () => vegetableService.toggleSeason(season, ref),
                          backgroundColor: buttonColor,
                          child: Text(season.toString().split('.').last),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 50,
                  height: 80,
                  child: FloatingActionButton(
                    onPressed: (){
                      if (seasonCheckResults.isNotEmpty) {
                      vegetableService.nextVegetable(ref);
                      } else {
                      vegetableService.updateSeasonCheckResults(ref);
                      vegetableService.calculateAndUpdateSeasonPoints(ref);
                      }
                    },
                    backgroundColor: Colors.grey,
                    child: const Text("GO"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
