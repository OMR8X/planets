import 'package:flutter/material.dart';
import 'package:planets/helpers/colors_h.dart';

class LandLayerWidget extends StatelessWidget {
  const LandLayerWidget({
    super.key,
    required this.size,
  });
  final Size size;
  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
        tween: Tween<double>(begin: 2, end: 1),
        duration: const Duration(milliseconds: 1000),
        curve: Curves.easeInOutCubic,
        builder: (context, value, child) {
          return Align(
            alignment: Alignment(0, value),
            child: CustomPaint(
              size: Size(size.width, size.height * 0.25),
              painter: LandPainter(),
            ),
          );
        });
  }
}

class LandPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    double w = size.width, h = size.height;
    Paint paint1 = Paint();
    Paint paint2 = Paint();
    paint1.color = ColorsHelper.grey;
    paint1.style = PaintingStyle.fill;
    paint2.color = ColorsHelper.greyDrk;
    paint2.style = PaintingStyle.fill;
    //
    Path p1 = Path();
    Path p2 = Path();
    p1.moveTo(w, h);
    p1.lineTo(0, h);
    p1.lineTo(0, 0);
    p1.lineTo(w, 0);
    //
    p2.moveTo(size.width, h);
    p2.lineTo(0, h);
    p2.lineTo(0, h * 0.2);
    p2.lineTo(w, h * 0.12);
    p2.close();
    //
    canvas.drawPath(p1, paint1);
    canvas.drawPath(p2, paint2);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
