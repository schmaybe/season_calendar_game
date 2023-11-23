import 'package:flutter/material.dart';

class AnimatedStar extends StatefulWidget {
  final int index;
  final double rating;
  final Duration delay;

  const AnimatedStar({
    Key? key,
    required this.index,
    required this.rating,
    required this.delay,
  }) : super(key: key);

  @override
  AnimatedStarState createState() => AnimatedStarState();
}

class AnimatedStarState extends State<AnimatedStar> {
  double size = 0;
  double opacity = 0;

  @override
  void initState() {
    super.initState();
    Future.delayed(widget.delay, () {
      if (mounted) {
        setState(() {
          opacity = 1;
          size = 20;
        });
        Future.delayed(const Duration(milliseconds: 200), () {
          if (mounted) {
            setState(() {
              size = 70;
            });
            Future.delayed(const Duration(milliseconds: 200), () {
              if (mounted) {
                setState(() {
                  size = 20;
                });
              }
            });
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: opacity,
      duration: const Duration(milliseconds: 200),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 400),
        width: size,
        height: size,
        child: Icon(
          Icons.star,
          color: widget.index < widget.rating ? Colors.amber.shade500 : Colors.grey,
        ),
      ),
    );
  }
}