import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:season_calendar_game/model/option.dart';
import '../providers/providers.dart';
import '../shared/constants.dart';
import '../shared/custom_widgets/slider.dart';

class OptionScreen extends ConsumerWidget {
  const OptionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final difficulty = ref.watch(difficultyProvider);

    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: const AssetImage("assets/app/vegetable_stripe.png"),
            colorFilter: ColorFilter.mode(
              Colors.grey.withOpacity(1),
              BlendMode.darken,
            ),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height*0.08),
            const Text(
              "Wie schnell bist du ??",
              style: TextStyle(
                color: Colors.white,
                fontSize: 50,
                fontWeight: FontWeight.bold,
                fontFamily: fontFamily,
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height*0.05),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(
                "Hier kannst du die Zeit pro Gemüse anpassen. Mit jedem Level hast du 5 Sekunden weniger Zeit: \n"
                "leicht: Startzeit 30s\n"
                "mittel: Startzeit 25s\n"
                "schwer: Startzeit 20s    ",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                  fontFamily: fontFamily,
                ),
                textAlign: TextAlign.center, // Zentriert den Text
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height*0.04),
            SizedBox(
              width: MediaQuery.of(context).size.width*0.7,
              height: MediaQuery.of(context).size.height*0.12,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SliderTheme(
                    data: CustomSliderTheme.customSliderTheme,
                    child: Slider(
                      value: difficulty.index.toDouble(),
                      min: 0,
                      max: Difficulty.values.length - 1,
                      divisions: Difficulty.values.length - 1,
                      onChanged: (double value) {
                        ref.read(difficultyProvider.notifier).state = Difficulty.values[value.toInt()];
                      },
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: buildSliderLabels(),
                  ),
                ],
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height*0.08),
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
    );
  }
}
