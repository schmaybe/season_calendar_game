import 'package:flutter/material.dart';

Widget buildSeasonScoreIndicator(int points) {
  return Container(
    padding: const EdgeInsets.all(2),
    decoration: BoxDecoration(
      color: points >= 0 ? Colors.green : Colors.red,
      borderRadius: BorderRadius.circular(4),
    ),
    child: Text(
      points >= 0 ? '+$points' : '$points',
      style: const TextStyle(color: Colors.white, fontSize: 12),
    ),
  );
}




