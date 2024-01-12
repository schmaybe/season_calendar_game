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
                      Text(
                        text,
                        style: const TextStyle(
                          fontSize: 27,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        "Level $level nicht geschafft!",
                        style: const TextStyle(
                          fontSize: 27,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 70 ),
                      Text(
                        "Dein Score: $score",
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "Maximum Score: $maxScore",
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 60),
                      // TextButton(
                      //   style: ButtonStyle(
                      //     elevation: MaterialStateProperty.all(BorderSide
                      //         .strokeAlignOutside),
                      //     backgroundColor: MaterialStateProperty.all(Colors
                      //         .amber.shade500),
                      //   ),
                      //   child: const Text(
                      //     "Retry Game",
                      //     style: TextStyle(
                      //       color: Colors.white,
                      //       fontSize: 20,
                      //       fontWeight: FontWeight.bold,
                      //       letterSpacing: 4,
                      //     ),
                      //   ),
                      //   onPressed: () {
                      //     timerExpired();
                      //     Navigator.popUntil(context, ModalRoute.withName("/startScreen"));
                      //   },
                      // ),
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: const MaterialStatePropertyAll(Colors.transparent),
                          elevation: const MaterialStatePropertyAll(0),
                          padding: MaterialStateProperty.all(
                            const EdgeInsets.symmetric(horizontal: 80, vertical: 10),
                          ),
                          shape: MaterialStateProperty.all(
                            const RoundedRectangleBorder(
                              side: BorderSide(
                                color: Colors.white,
                                width: 2,
                              ),
                            ),
                          ),
                        ),
                        onPressed: () {
                          timerExpired();
                          Navigator.popUntil(context, ModalRoute.withName("/startScreen"));
                        },
                        child: const Text(
                          "Zurück",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                          ),
                        ),
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