import 'package:flutter/material.dart';
import '../shared/custom_widgets/rotation_animation.dart';

class EndScreen extends StatefulWidget {
  final int initialRating;
  const EndScreen({Key? key, required this.initialRating}) : super(key: key);

  @override
  EndScreenState createState() => EndScreenState();
}

class EndScreenState extends State<EndScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late String secretText;
  late String secretImage;
  late int receivedRating;
  bool shouldShowText = false;
  bool isButtonVisible = false;
  double textOpacity = 0.0;

  ImageRotationData imageData = ImageRotationData(rotation: -1.0, translateY: -1.0);

  @override
  void initState() {
    super.initState();
    _startButtonVisibilityTimer();
    receivedRating = widget.initialRating;
    _getSecretImageAndText();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    _animation = Tween(begin: -0.5, end: 1.3).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    _controller.forward();
    _controller.addListener(() {
      setState(() {
        imageData = ImageRotationData(rotation: _animation.value, translateY: _animation.value);
        if (_controller.status == AnimationStatus.completed && !shouldShowText) {
          shouldShowText = true;
          _startTextAnimation();
        }
      });
    });
  }

  void _getSecretImageAndText() {
    switch (receivedRating) {
      case 5:
        secretText = "Dein Wissen schockt alles!!!";
        secretImage = "assets/end/artichoke.png";
        break;
      case 4:
        secretText = "Dein Wissen ist sehr Vielschichtig!!!";
        secretImage = "assets/end/onion.png";
        break;
      case 3:
        secretText = "Dein Wissen schockt alles!!!";
        secretImage = "assets/end/artichoke.png";
        break;
      case 2:
        secretText = "Dein Wissen ist sehr Vielschichtig!!!";
        secretImage = "assets/end/onion.png";
        break;
      case 1:
        secretText = "Dein Wissen schockt alles!!!";
        secretImage = "assets/end/artichoke.png";
        break;
    }
  }

  void _startTextAnimation() {
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        textOpacity = 0.1;
        _animateTextOpacity();
      });
    });
  }

  void _animateTextOpacity() {
    if (textOpacity < 1.0) {
      Future.delayed(const Duration(milliseconds: 100), () {
        setState(() {
          textOpacity += 0.1;
          textOpacity = textOpacity.clamp(0.0, 1.0);
        });
        _animateTextOpacity();
      });
    }
  }

  void _startButtonVisibilityTimer() {
    Future.delayed(const Duration(seconds: 7), () {
      if (mounted) {
        setState(() {
          isButtonVisible = true;
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Transform.scale(
                  scale: imageData.rotation,
                  child: Transform.rotate(
                    angle: imageData.rotation * 4.8,
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(secretImage),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(60),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          AnimatedOpacity(
            opacity: shouldShowText ? textOpacity : 0.0,
            duration: const Duration(milliseconds: 1000),
            curve: Curves.easeOut,
            child: Align(
              alignment: Alignment.bottomCenter - const Alignment(0.0, 0.6),
              child: TweenAnimationBuilder(
                duration: const Duration(milliseconds: 6000),
                tween: Tween(begin: -20.0, end: -5.0),
                builder: (context, double value, child) {
                  return Transform.translate(
                    offset: Offset(value, 0),
                    child: Text(
                      secretText,
                      style: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          AnimatedOpacity(
            opacity: isButtonVisible ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 2000),
            curve: Curves.easeInOut,
            child: Align(
              alignment: Alignment.bottomCenter - const Alignment(0.0, 0.1),
               child: ElevatedButton(
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
            ),
          ),
        ],
      ),
    );
  }
}



