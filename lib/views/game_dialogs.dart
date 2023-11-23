import 'package:flutter/material.dart';
class GameDialogs{

  static void showLevelCompletedDialog(BuildContext context, int score, int level, VoidCallback onNextLevel) {
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
                    color: Colors.grey.shade300,
                  ),
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: 400,
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text("Level ${level-1} Completed!", style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 20),
                      Text("Your score: $score", style: const TextStyle(fontSize: 16)),
                      const SizedBox(height: 20),
                      TextButton(
                        child: const Text("Next Level"),
                        onPressed: () {
                          Navigator.of(context).pop();
                          onNextLevel();
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