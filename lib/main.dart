import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:season_calendar_game/shared/media_query_size.dart';
import 'package:season_calendar_game/views/end_screen.dart';
import 'package:season_calendar_game/views/game_root.dart';
import 'package:season_calendar_game/views/option_screen.dart';
import 'package:season_calendar_game/views/start_screen.dart';

void main() {
  runApp(
    const ProviderScope(
        child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
   setMediaSize(context);
    return MaterialApp(
      initialRoute: "/startScreen",
      routes: {
        "/startScreen": (context) => StartScreen(),
        "/gameRoot": (context) => GameRoot(),
        "/optionScreen": (context) => OptionScreen(),
        // "/endScreen": (context) => EndScreen(initialRating: 1)
      },
      home: StartScreen(),
    );
  }
}
