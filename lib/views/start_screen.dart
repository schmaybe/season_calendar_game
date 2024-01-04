import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/providers.dart';
import '../shared/constants.dart';

class StartScreen extends ConsumerWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
            SizedBox(height: MediaQuery.of(context).size.height*0.1),
            const Text(
              "Wann wächst was ??",
              style: TextStyle(
                color: Colors.white,
                fontSize: 50,
                fontWeight: FontWeight.bold,
                fontFamily: fontFamily,
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height*0.2),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: const MaterialStatePropertyAll(Colors.transparent),
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
                Navigator.of(context).pushNamed("/gameRoot");
              },
              child: const Text(
                "Gemüse",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height*0.06),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: const MaterialStatePropertyAll(Colors.transparent),
                elevation: const MaterialStatePropertyAll(0),
                padding: MaterialStateProperty.all(
                  const EdgeInsets.symmetric(horizontal: 65, vertical: 10),
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
                Navigator.of(context).pushNamed("/optionScreen");
              },
              child: const Text(
                "Optionen",
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
