import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:season_calendar_game/model/option.dart';
import 'package:season_calendar_game/shared/media_query_size.dart';
import '../providers/providers.dart';
import '../shared/constants.dart';
import '../shared/custom_widgets/slider.dart';

class OptionScreen extends ConsumerWidget {
  const OptionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final difficulty = ref.watch(difficultyProvider);
    final double mediaWidth = getMediaWidthSize();
    final double mediaHeight = getMediaHeightSize();

    return Scaffold(
      body: Container(
        width: mediaWidth,
        height: mediaHeight,
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
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: mediaHeight*0.05),
              Text(
                "Wie schnell bist du ??",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: mediaWidth*0.1,
                  fontWeight: FontWeight.bold,
                  fontFamily: fontFamily,
                ),
              ),
              SizedBox(height: mediaHeight*0.04),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Text(
                  "Hier kannst du die Zeit pro Gemüse anpassen. Mit jedem Level hast du 5 Sekunden weniger Zeit: \n"
                  "leicht: Startzeit 30s\n"
                  "mittel: Startzeit 25s\n"
                  "schwer: Startzeit 20s    ",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: mediaWidth*0.07,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center, // Zentriert den Text
                ),
              ),
              SizedBox(height: mediaHeight*0.04),
              SizedBox(
                width: mediaWidth*0.7,
                height: mediaHeight*0.12,
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
                      bottom: -10.0,
                      left: 0,
                      right: 0,
                      child: buildSliderLabels(),
                    ),
                  ],
                ),
              ),
              SizedBox(height: mediaHeight*0.05),
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
    );
  }
}
