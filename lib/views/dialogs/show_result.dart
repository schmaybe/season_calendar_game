import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/providers.dart';
import '../../shared/custom_widgets/animated_star.dart';
import '../../shared/media_query_size.dart';
import '../end_screen.dart';

class GameDialogShowResult {

  static void showResultDialog(BuildContext context, WidgetRef ref) {
    final vegetableService = ref.watch(vegetableServiceProvider);
    final double mediaWidth = getMediaWidthSize();
    final double mediaHeight = getMediaHeightSize();
    int totalScore = vegetableService.scoreLevel1+vegetableService.scoreLevel2+vegetableService.scoreLevel3+vegetableService.scoreLevel4;
    int totalMaxScore = vegetableService.maxScoreLevel1+vegetableService.maxScoreLevel2+vegetableService.maxScoreLevel3+vegetableService.maxScoreLevel4;
    double rating = (totalScore/totalMaxScore)*5;
    int endScreenRating = rating.round();
    print(rating);
    print(endScreenRating);
    print(vegetableService.scoreLevel1);
    print(vegetableService.scoreLevel2);
    print(vegetableService.scoreLevel3);
    print(vegetableService.scoreLevel4);
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Center(
          child: Stack(
            children: <Widget>[
              Positioned(
                top: mediaHeight*0.05,
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
                          "Endergebnis:",
                          style: TextStyle(
                            fontSize: mediaWidth*0.07,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: mediaHeight*0.02),
                        RatingBar.builder(
                          initialRating: rating,
                          ignoreGestures: true,
                          allowHalfRating: true,
                          direction: Axis.horizontal,
                          itemCount: 5,
                          itemPadding: const EdgeInsets.symmetric(
                              horizontal: 3.0),
                          itemBuilder: (context, index) {
                            return AnimatedStar(
                              index: index,
                              rating: rating,
                              delay: Duration(milliseconds: index * 800),
                            );
                          },
                          onRatingUpdate: (double value) {},
                        ),
                        SizedBox(height: mediaHeight*0.04),
                        Row(
                          children: [
                            Expanded(
                              flex: 0,
                              child: Padding(
                                padding: EdgeInsets.only(left: mediaWidth*0.04),
                                child: Text(
                                  "Level 1: ",
                                  style: TextStyle(
                                    fontSize: mediaWidth*0.05,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Text(
                                "${vegetableService.scoreLevel1}",
                                style: TextStyle(
                                  fontSize: mediaWidth*0.05,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 0,
                              child: Padding(
                                padding: EdgeInsets.only(right: mediaWidth*0.04),
                                child: Text(
                                  "(max. ${vegetableService.maxScoreLevel1})",
                                  style: TextStyle(
                                    fontSize: mediaWidth*0.05,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: mediaHeight*0.02),
                        Row(
                          children: [
                            Expanded(
                              flex: 0,
                              child: Padding(
                                padding: EdgeInsets.only(left: mediaWidth*0.04),
                                child: Text(
                                  "Level 2: ",
                                  style: TextStyle(
                                    fontSize: mediaWidth*0.05,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Text(
                                "${vegetableService.scoreLevel2}",
                                style: TextStyle(
                                  fontSize: mediaWidth*0.05,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 0,
                              child: Padding(
                                padding: EdgeInsets.only(right: mediaWidth*0.04),
                                child: Text(
                                  "(max. ${vegetableService.maxScoreLevel2})",
                                  style: TextStyle(
                                    fontSize: mediaWidth*0.05,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: mediaHeight*0.02),
                        Row(
                          children: [
                            Expanded(
                              flex: 0,
                              child: Padding(
                                padding: EdgeInsets.only(left: mediaWidth*0.04),
                                child: Text(
                                  "Level 3: ",
                                  style: TextStyle(
                                    fontSize: mediaWidth*0.05,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Text(
                                "${vegetableService.scoreLevel3}",
                                style: TextStyle(
                                  fontSize: mediaWidth*0.05,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 0,
                              child: Padding(
                                padding: EdgeInsets.only(right: mediaWidth*0.04),
                                child: Text(
                                  "(max. ${vegetableService.maxScoreLevel3})",
                                  style: TextStyle(
                                    fontSize: mediaWidth*0.05,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: mediaHeight*0.02),
                        Row(
                          children: [
                            Expanded(
                              flex: 0,
                              child: Padding(
                                padding: EdgeInsets.only(left: mediaWidth*0.04),
                                child: Text(
                                  "Level 4: ",
                                  style: TextStyle(
                                    fontSize: mediaWidth*0.05,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Text(
                                "${vegetableService.scoreLevel4}",
                                style: TextStyle(
                                  fontSize: mediaWidth*0.05,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 0,
                              child: Padding(
                                padding: EdgeInsets.only(right: mediaWidth*0.04),
                                child: Text(
                                  "(max. ${vegetableService.maxScoreLevel4})",
                                  style: TextStyle(
                                    fontSize: mediaWidth*0.05,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: mediaHeight*0.03),
                        TextButton(
                          style: ButtonStyle(
                            elevation: MaterialStateProperty.all(
                                BorderSide.strokeAlignOutside),
                            backgroundColor: MaterialStateProperty.all(
                                Colors.amber.shade500),
                          ),
                          child: Text(
                            "Weiter..",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: mediaWidth*0.05,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 4,
                            ),
                          ),
                          // onPressed: () {
                          //   Navigator.popUntil(context, ModalRoute.withName("/startScreen"));
                          // },
                          onPressed: () {
                            Navigator.push(context,
                              MaterialPageRoute(
                                builder: (context) => EndScreen(initialRating: endScreenRating),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}