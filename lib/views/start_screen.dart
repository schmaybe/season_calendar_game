import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:season_calendar_game/views/game_root.dart';
import '../providers/providers.dart';
import '../shared/custom_widgets/constants.dart';

class StartScreen extends ConsumerWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          color: colorGameTheme,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height*0.1),
            const Text(
              "Wann wächst was ???",
              style: TextStyle(
                color: Colors.white,
                fontSize: 45,
                fontWeight: FontWeight.bold,
                fontFamily: fontFamily,
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height*0.1),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: const MaterialStatePropertyAll(colorGameTheme),
                elevation: const MaterialStatePropertyAll(0),
                padding: MaterialStateProperty.all(
                  const EdgeInsets.symmetric(horizontal: 70, vertical: 10),
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
                ref.read(vegetableServiceProvider).resetGame(ref);
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => const GameRoot(),
                ));
              },
              child: const Text(
                "Gemüse",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height*0.04),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: const MaterialStatePropertyAll(colorGameTheme),
                elevation: const MaterialStatePropertyAll(0),
                padding: MaterialStateProperty.all(
                  const EdgeInsets.symmetric(horizontal: 93, vertical: 10),
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
              onPressed: () {},
              child: const Text(
                "Obst",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height*0.04),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: const MaterialStatePropertyAll(colorGameTheme),
                elevation: const MaterialStatePropertyAll(0),
                padding: MaterialStateProperty.all(
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
              onPressed: () {},
              child: const Text(
                "Obst & Gemüse",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                ),
              ),
            ),
            Row(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 250,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage("assets/app/trees.png"),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
