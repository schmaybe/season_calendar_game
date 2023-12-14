import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../model/vegetable.dart';
import '../providers/providers.dart';
import '../shared/constants.dart';
import '../shared/custom_widgets/score.dart';

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
    final timerHandlerV1 = ref.read(timerHandlerProviderV1);
    final timerHandlerV2 = ref.read(timerHandlerProviderV2);
    final levelHandler = ref.read(levelCompletedProvider2);
    final timerValue = ref.watch(timerServiceProvider);
    final levelCompleted = ref.watch(levelCompletedProvider);
    
    levelHandler.handleLevelCompleted(context, ref);
    timerHandlerV2.handleTimer(context, ref);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
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
              child: Text("$timerValue"),
            ),
            Expanded(
              flex: 1,
              child: IconButton(
                onPressed: () {
                  // ref.read(timerServiceProvider.notifier).stopTimer();
                  timerHandlerV2.resetTimer();
                  //Future.microtask(() => ref.read(timerServiceProvider.notifier).resetTimer());
                  Navigator.popUntil(context, ModalRoute.withName("/startScreen"));
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
            image: const AssetImage("assets/app/background2.jpg"),
            colorFilter: ColorFilter.mode(
              Colors.grey.shade700.withOpacity(0.4),
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
                Color buttonColor = selectedSeasons.contains(season) ? Colors.white.withOpacity(0.4) : Colors.transparent;
                if (seasonCheckResults.isNotEmpty) {
                  buttonColor = seasonCheckResults[season]! ? Colors.white.withOpacity(0.4) : Colors.transparent;
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
                        child: ElevatedButton(
                          onPressed: () => vegetableService.toggleSeason(season, ref),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: buttonColor,
                            shadowColor: Colors.transparent,
                            elevation: 0,
                            padding: EdgeInsets.zero,
                            fixedSize: const Size(70, 70),
                            tapTargetSize: MaterialTapTargetSize.padded,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                          ),
                          child: Container(
                            width: 55,
                            height: 55,
                            child: Image.asset(
                              vegetableService.getImageForSeason(season),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        // child: FloatingActionButton(
                        //   heroTag: null,
                        //   onPressed: () => vegetableService.toggleSeason(season, ref),
                        //   backgroundColor: buttonColor,
                        //   child: Text(season.toString().split('.').last),
                        // ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: MediaQuery.of(context).size.height*0.06),
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
                //start timer for next vegetable
                if(!levelCompleted){
                  timerHandlerV2.startTimer();
                }
                } else {
                //stop timer for current vegetable
                timerHandlerV2.stopTimer();
                //check values
                vegetableService.updateSeasonCheckResults(ref);
                vegetableService.calculateAndUpdateSeasonPoints(ref);
                }
              },
              child: const Text("GO"),
            ),
            SizedBox(height: MediaQuery.of(context).size.height*0.02),
          ],
        ),
      ),
    );
  }
}
