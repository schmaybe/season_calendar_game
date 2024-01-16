import 'package:flutter/material.dart';

import '../constants.dart';

class CustomSliderTheme {
  static SliderThemeData get customSliderTheme {
    return SliderThemeData(
      activeTrackColor: Colors.white,
      inactiveTrackColor: Colors.white54,
      trackHeight: 6.0,
      thumbColor: Colors.white,
      inactiveTickMarkColor: Colors.white,
      tickMarkShape: const RoundSliderTickMarkShape(tickMarkRadius: 8.0),
      thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 20.0),
      overlayColor: Colors.white.withAlpha(32),
      overlayShape: const RoundSliderOverlayShape(overlayRadius: 20.0),
    );
  }
}

Widget buildSliderLabels() {
  return const Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text('leicht', style: TextStyle(color: Colors.white, fontSize: 30.0, fontFamily: fontFamily,fontWeight: FontWeight.bold)),
      Text('mittel', style: TextStyle(color: Colors.white, fontSize: 30.0, fontFamily: fontFamily,fontWeight: FontWeight.bold)),
      Text('schwer', style: TextStyle(color: Colors.white, fontSize: 30.0, fontFamily: fontFamily,fontWeight: FontWeight.bold)),
    ],
  );
}

