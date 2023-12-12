import 'package:flutter/material.dart';
import '../../shared/constants.dart';

class GameDialogLevelFailed {

  static void showLevelFailedDialog(BuildContext context, int level, int score, int maxScore, String text, VoidCallback timerExpired) {
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
                    color: colorGameTheme,
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
                        text,
                        style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        "Level $level failed!",
                        style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 60),
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
                      const SizedBox(height: 60),
                      TextButton(
                        style: ButtonStyle(
                          elevation: MaterialStateProperty.all(BorderSide
                              .strokeAlignOutside),
                          backgroundColor: MaterialStateProperty.all(Colors
                              .amber.shade500),
                        ),
                        child: const Text(
                          "Retry Game",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 4,
                          ),
                        ),
                        onPressed: () {
                          timerExpired();
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