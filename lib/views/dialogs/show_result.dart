import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/providers.dart';
import '../../shared/custom_widgets/animated_star.dart';
import '../../shared/constants.dart';

class GameDialogShowResult {

  static void showResultDialog(BuildContext context, WidgetRef ref) {
    final vegetableService = ref.watch(vegetableServiceProvider);
    int totalScore = vegetableService.scoreLevel1+vegetableService.scoreLevel2+vegetableService.scoreLevel3+vegetableService.scoreLevel4;
    int totalMaxScore = vegetableService.maxScoreLevel1+vegetableService.maxScoreLevel2+vegetableService.maxScoreLevel3+vegetableService.maxScoreLevel4;
    double rating = (totalScore/totalMaxScore)*5;
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
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: 400,
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const Text(
                        "Result set:",
                        style: TextStyle(
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
                      const SizedBox(height: 30),
                      Row(
                        children: [
                          const Expanded(
                            flex: 0,
                            child: Padding(
                              padding: EdgeInsets.only(left: 45.0),
                              child: Text(
                                "level1: ",
                                style: TextStyle(
                                  fontSize: 20,
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
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 0,
                            child: Padding(
                              padding: const EdgeInsets.only(right: 45.0),
                              child: Text(
                                "(max. ${vegetableService.maxScoreLevel1})",
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          const Expanded(
                            flex: 0,
                            child: Padding(
                              padding: EdgeInsets.only(left: 45.0),
                              child: Text(
                                "level2: ",
                                style: TextStyle(
                                  fontSize: 20,
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
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 0,
                            child: Padding(
                              padding: const EdgeInsets.only(right: 45.0),
                              child: Text(
                                "(max. ${vegetableService.maxScoreLevel2})",
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          const Expanded(
                            flex: 0,
                            child: Padding(
                              padding: EdgeInsets.only(left: 45.0),
                              child: Text(
                                "level3: ",
                                style: TextStyle(
                                  fontSize: 20,
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
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 0,
                            child: Padding(
                              padding: const EdgeInsets.only(right: 45.0),
                              child: Text(
                                "(max. ${vegetableService.maxScoreLevel3})",
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          const Expanded(
                            flex: 0,
                            child: Padding(
                              padding: EdgeInsets.only(left: 45.0),
                              child: Text(
                                "level4: ",
                                style: TextStyle(
                                  fontSize: 20,
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
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 0,
                            child: Padding(
                              padding: const EdgeInsets.only(right: 45.0),
                              child: Text(
                                "(max. ${vegetableService.maxScoreLevel4})",
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                      TextButton(
                        style: ButtonStyle(
                          elevation: MaterialStateProperty.all(
                              BorderSide.strokeAlignOutside),
                          backgroundColor: MaterialStateProperty.all(
                              Colors.amber.shade500),
                        ),
                        child: const Text(
                          "Back to menu",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 4,
                          ),
                        ),
                        onPressed: () {
                          Navigator.popUntil(context, ModalRoute.withName("/startScreen"));
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