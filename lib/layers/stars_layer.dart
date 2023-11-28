import 'dart:math';
import 'package:flutter/material.dart';

class StarsLayerWidget extends StatefulWidget {
  const StarsLayerWidget({
    super.key,
    this.duration,
    required this.size,
  });
  final Duration? duration;
  final Size size;
  @override
  State<StarsLayerWidget> createState() => _StarsLayerWidgetState();
}

class _StarsLayerWidgetState extends State<StarsLayerWidget>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation1;
  late Animation<double> _animation2;
  late Animation<double> _animation3;
  Size size = Size.zero;
  List<Star> stars1 = [];
  List<Star> stars2 = [];
  List<Star> stars3 = [];
  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1200),
    )..repeat();
    _animation1 = Tween<double>(begin: 0, end: 2 * pi).animate(_controller);
    _animation2 = Tween<double>(begin: 0, end: 2.1 * pi).animate(_controller);
    _animation3 = Tween<double>(begin: 0, end: 2.2 * pi).animate(_controller);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        size = MediaQuery.sizeOf(context);
        createStars();
      });
    });
    super.initState();
  }

  createStars() {
    for (int i = 0; i < 1000; i++) {
      stars1.add(
        Star(
          offset: Offset(
            Random().nextBool()
                ? (size.width / 2 + (size.height * Random().nextDouble()))
                : (size.width / 2 - (size.height * Random().nextDouble())),
            Random().nextBool()
                ? (size.height / 2 + (size.height * Random().nextDouble()))
                : (size.height / 2 - (size.height * Random().nextDouble())),
          ),
          color: Colors.white54,
          radius: 0.2 + Random().nextDouble(),
        ),
      );
    }
    for (int i = 0; i < 1000; i++) {
      stars2.add(
        Star(
          offset: Offset(
            Random().nextBool()
                ? (size.width / 2 + (size.height * Random().nextDouble()))
                : (size.width / 2 - (size.height * Random().nextDouble())),
            Random().nextBool()
                ? (size.height / 2 + (size.height * Random().nextDouble()))
                : (size.height / 2 - (size.height * Random().nextDouble())),
          ),
          color: Colors.white54,
          radius: 0.2 + Random().nextDouble(),
        ),
      );
    }
    for (int i = 0; i < 1000; i++) {
      stars3.add(
        Star(
          offset: Offset(
            Random().nextBool()
                ? (size.width / 2 + (size.height * Random().nextDouble()))
                : (size.width / 2 - (size.height * Random().nextDouble())),
            Random().nextBool()
                ? (size.height / 2 + (size.height * Random().nextDouble()))
                : (size.height / 2 - (size.height * Random().nextDouble())),
          ),
          color: Colors.white54,
          radius: 0.2 + Random().nextDouble(),
        ),
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Align(
          alignment: Alignment.center,
          child: Transform.scale(
            scale: 0.5,
            child: SizedBox(
              width: size.height,
              height: size.height,
              child: RotationTransition(
                turns: _animation1,
                child: CustomPaint(
                  painter: StarsPainter(stars: stars1),
                ),
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: Transform.scale(
            scale: 0.6,
            child: SizedBox(
              width: size.height,
              height: size.height,
              child: RotationTransition(
                turns: _animation2,
                child: CustomPaint(
                  painter: StarsPainter(stars: stars2),
                ),
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: Transform.scale(
            scale: 0.7,
            child: SizedBox(
              width: size.height,
              height: size.height,
              child: RotationTransition(
                turns: _animation3,
                child: CustomPaint(
                  painter: StarsPainter(stars: stars3),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class StarsPainter extends CustomPainter {
  final List<Star> stars;

  const StarsPainter({super.repaint, required this.stars});
  @override
  void paint(Canvas canvas, Size size) {
    double w = size.width, h = size.height;
    for (var star in stars) {
      paintStar(canvas, star);
    }
  }

  paintStar(Canvas canvas, Star star) {
    Paint paint = Paint();
    paint.color = star.color;

    canvas.drawCircle(star.offset, star.radius, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class Star {
  final Offset offset;
  final Color color;
  final double radius;
  Star({required this.offset, required this.color, required this.radius});
}
