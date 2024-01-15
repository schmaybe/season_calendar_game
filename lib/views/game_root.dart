import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../model/vegetable.dart';
import '../providers/providers.dart';
import '../shared/constants.dart';
import '../shared/custom_widgets/score.dart';
import '../shared/media_query_size.dart';

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
    final timerHandler = ref.read(timerHandlerProvider);
    final levelHandler = ref.read(levelCompletedProvider2);
    final timerValue = ref.watch(timerServiceProvider);
    final levelCompleted = ref.watch(levelCompletedProvider);
    final double mediaWidth = getMediaWidthSize();
    final double mediaHeight = getMediaHeightSize();
    
    levelHandler.handleLevelCompleted(context, ref);
    timerHandler.handleTimer(context, ref);

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
              child: Text(
                "Score $score",
                style: TextStyle(
                  fontFamily: fontFamily2,
                  fontWeight: FontWeight.bold,
                  fontSize: mediaWidth*0.05,
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Text(
                "Level $level",
                style: TextStyle(
                  fontFamily: fontFamily2,
                  fontWeight: FontWeight.bold,
                  fontSize: mediaWidth*0.05,
                ),

              ),
            ),
            Expanded(
              flex: 2,
              child: Text(
                "$timerValue",
                style: TextStyle(
                  fontFamily: fontFamily2,
                  fontWeight: FontWeight.bold,
                  fontSize: mediaWidth*0.05,
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: IconButton(
                onPressed: () {
                  // ref.read(timerServiceProvider.notifier).stopTimer();
                  timerHandler.resetTimer();
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
                  height: MediaQuery.of(context).size.height*0.45,
                  child: Image.asset(vegetableService.currentVegetable.imgPath),
                ),
            ),
            Text(
                style: TextStyle(
                  fontSize: mediaWidth*0.06,
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
                  padding: EdgeInsets.only(top: mediaWidth*0.05),
                  child: Column(
                    children: [
                      if (seasonPoints.containsKey(season))
                        buildSeasonScoreIndicator(seasonPoints[season]!),
                      SizedBox(height: mediaHeight*0.02),
                      SizedBox(
                        width: mediaWidth*0.2,
                        height: mediaHeight*0.11,
                        child: ElevatedButton(
                          onPressed: () => vegetableService.toggleSeason(season, ref),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: buttonColor,
                            shadowColor: Colors.transparent,
                            elevation: 0,
                            padding: EdgeInsets.zero,
                            // fixedSize: const Size(70, 70),
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
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: mediaHeight*0.06),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: const MaterialStatePropertyAll(colorGameTheme2),
                elevation: const MaterialStatePropertyAll(0),
                padding: MaterialStateProperty.all(
                  EdgeInsets.symmetric(horizontal: mediaWidth*0.3, vertical: mediaHeight*0.01),
                ),
              ),
              onPressed: (){
                if (seasonCheckResults.isNotEmpty) {
                vegetableService.nextVegetable(ref);
                //start timer for next vegetable
                if(!levelCompleted){
                  timerHandler.startTimer();
                }
                } else {
                //stop timer for current vegetable
                timerHandler.stopTimer();
                //check values
                vegetableService.updateSeasonCheckResults(ref);
                vegetableService.calculateAndUpdateSeasonPoints(ref);
                }
              },
              child: Text(
                "G O",
                style: TextStyle(
                  fontFamily: fontFamily2,
                  fontWeight: FontWeight.bold,
                  fontSize: mediaWidth*0.05,
                ),
              ),
            ),
            SizedBox(height: mediaHeight*0.03),
          ],
        ),
      ),
    );
  }
}
