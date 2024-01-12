import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:season_calendar_game/views/dialogs/show_result.dart';
import '../../shared/custom_widgets/animated_star.dart';
import '../../shared/constants.dart';
import '../../shared/media_query_size.dart';

class GameDialogLevelCompleted {

  static void showLevelCompletedDialog(BuildContext context, WidgetRef ref, int score,
      int maxScore, int level, VoidCallback onNextLevel) {
    double rating = (score / maxScore) * 5;
    final double mediaWidth = getMediaWidthSize();
    final double mediaHeight = getMediaHeightSize();
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
                    borderRadius: BorderRadius.circular(20.0),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: const AssetImage("assets/app/background2.jpg"),
                      colorFilter: ColorFilter.mode(
                        Colors.grey.shade700.withOpacity(0.4),
                        BlendMode.darken,
                      ),
                    ),
                  ),
                  width: mediaWidth * 0.8,
                  height: mediaHeight * 0.6,
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        "Level $level geschafft!",
                        style: TextStyle(
                          fontSize: mediaWidth*0.07,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: mediaHeight*0.05),
                      RatingBar.builder(
                        initialRating: rating,
                        ignoreGestures: true,
                        allowHalfRating: true,
                        direction: Axis.horizontal,
                        itemCount: 5,
                        itemPadding: const EdgeInsets.symmetric(horizontal: 3.0),
                        itemBuilder: (context, index) {
                          return AnimatedStar(
                            index: index,
                            rating: rating,
                            delay: Duration(milliseconds: index * 800),
                          );
                        },
                        onRatingUpdate: (double value) {},
                      ),
                      SizedBox(height: mediaHeight*0.05),
                      Text(
                        "Dein score: $score",
                        style: TextStyle(
                          fontSize: mediaWidth*0.07,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: mediaHeight*0.03),
                      Text(
                        "max. score: $maxScore",
                        style: TextStyle(
                          fontSize: mediaWidth*0.07,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: mediaHeight*0.05),
                      TextButton(
                        style: ButtonStyle(
                          elevation: MaterialStateProperty.all(BorderSide
                              .strokeAlignOutside),
                          backgroundColor: MaterialStateProperty.all(Colors
                              .amber.shade500),
                        ),
                        child: Text(
                          level >= 4 ? "Endergebnis" : "Nächstes Level",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: mediaWidth*0.05,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 4,
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                          if (level >= 4) {
                            onNextLevel();
                            Future.microtask(() => GameDialogShowResult.showResultDialog(context, ref));
                          } else {
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