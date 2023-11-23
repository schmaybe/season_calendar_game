import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:season_calendar_game/views/start_screen.dart';
import '../custom_widgets/animated_star.dart';

class GameDialogs{

  static void showLevelCompletedDialog(BuildContext context, int score, int maxScore, int level, VoidCallback onNextLevel) {
    double rating = (score/maxScore) * 5;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Stack(
          children: <Widget>[
            Positioned(
              top: 50,
              child: Dialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(20.0),
                    // image: const DecorationImage(
                    //   fit: BoxFit.cover,
                    //   image: AssetImage("assets/app/wheat.jpg"),
                    // ),
                  ),
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: 400,
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                          "Level $level Completed!",
                          style: const TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                      ),
                      const SizedBox(height: 50),
                      RatingBar.builder(
                        initialRating: rating,
                        ignoreGestures: true,
                        allowHalfRating: true,
                        direction: Axis.horizontal,
                        itemCount: 5,
                        itemPadding: const EdgeInsets.symmetric(horizontal: 3.0),
                        // itemBuilder: (context, _) => const Icon(
                        //   Icons.star,
                        //   color: Colors.amber,
                        // ),
                        itemBuilder: (context, index) {
                          return AnimatedStar(
                            index: index,
                            rating: rating,
                            delay: Duration(milliseconds: index * 800),
                          );
                        },
                        onRatingUpdate: (double value) {},
                      ),
                      const SizedBox(height: 50),
                      Text(
                        "Your score: $score",
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "Maximum score: $maxScore",
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 50),
                      TextButton(
                        style: ButtonStyle(
                          elevation: MaterialStateProperty.all(BorderSide.strokeAlignOutside),
                          backgroundColor: MaterialStateProperty.all(Colors.amber.shade500),
                        ),
                        child: const Text(
                          "Next Level",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 4,
                          ),
                        ),
                        onPressed: () {
                          if(level >= 4){
                            Navigator.of(context).pop();
                            Navigator.of(context).pop();
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const StartScreen(), // Ihr StartScreen-Widget
                            ));
                          }else {
                            Navigator.of(context).pop();
                            onNextLevel();
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

}