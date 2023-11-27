import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:season_calendar_game/views/start_screen.dart';
import '../model/vegetable.dart';
import '../providers/providers.dart';
import '../shared/custom_widgets/constants.dart';
import '../shared/custom_widgets/score.dart';
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
      if (level <= 4) {
        Future.microtask(() =>
            GameDialogs.showLevelCompletedDialog(
              context,
              ref,
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
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorGameTheme2,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              flex: 3,
              child: Text("Score $score"),
            ),
            Expanded(
              flex: 3,
              child: Text("Level $level"),
            ),
            Expanded(
              flex: 2,
              child: Text("Timer"),
            ),
            Expanded(
              flex: 1,
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const StartScreen(),
                    ),
                  );
                },
                icon: const Icon(Icons.home),
              ),
            ),
          ],
        ),
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
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height*0.5,
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
                Color buttonColor = selectedSeasons.contains(season) ? Colors.green : colorGameTheme2;
                if (seasonCheckResults.isNotEmpty) {
                  buttonColor = seasonCheckResults[season]! ? Colors.green : colorGameTheme2;
                }
                return Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Column(
                    children: [
                      if (seasonPoints.containsKey(season))
                        buildSeasonScoreIndicator(seasonPoints[season]!),
                      SizedBox(height: MediaQuery.of(context).size.height*0.02),
                      SizedBox(
                        width: MediaQuery.of(context).size.width*0.2,
                        height: MediaQuery.of(context).size.height*0.11,
                        child: FloatingActionButton(
                          heroTag: null,
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
            SizedBox(height: MediaQuery.of(context).size.height*0.07),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: const MaterialStatePropertyAll(colorGameTheme2),
                elevation: const MaterialStatePropertyAll(0),
                padding: MaterialStateProperty.all(
                  EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*0.3, vertical: 12),
                ),
              ),
              onPressed: (){
                if (seasonCheckResults.isNotEmpty) {
                vegetableService.nextVegetable(ref);
                } else {
                vegetableService.updateSeasonCheckResults(ref);
                vegetableService.calculateAndUpdateSeasonPoints(ref);
                }
              },
              child: const Text("GO"),
            ),
          ],
        ),
      ),
    );
  }
}
