import 'package:flutter/material.dart';
import '../../shared/constants.dart';
import '../../shared/media_query_size.dart';

class GameDialogLevelFailed {

  static void showLevelFailedDialog(BuildContext context, int level, int score, int maxScore, String text, VoidCallback timerExpired) {
    final double mediaWidth = getMediaWidthSize();
    final double mediaHeight = getMediaHeightSize();
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
                        SizedBox(height: mediaHeight*0.02),
                        Text(
                          text,
                          style: TextStyle(
                            fontSize: mediaWidth*0.06,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: mediaHeight*0.05),
                        Text(
                          "Level $level nicht geschafft!",
                          style: TextStyle(
                            fontSize: mediaWidth*0.06,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: mediaHeight*0.05),
                        Text(
                          "Dein Score: $score",
                          style: TextStyle(
                            fontSize: mediaWidth*0.05,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "Maximum Score: $maxScore",
                          style: TextStyle(
                            fontSize: mediaWidth*0.05,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: mediaHeight*0.07),
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
                          child: Text(
                            "Zurück",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: mediaWidth*0.07,
                            ),
                          ),
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