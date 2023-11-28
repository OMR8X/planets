import 'dart:math';

import 'package:flutter/material.dart';

class SpacePageRoute extends PageRouteBuilder {
  final Widget page;
  SpacePageRoute({required this.page})
      : super(
            transitionDuration: const Duration(milliseconds: 900),
            reverseTransitionDuration: const Duration(milliseconds: 900),
            pageBuilder: (context, animation, secondaryAnimation) => page);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return Stack(
      children: [
        ClipPath(
          clipper: Caliper(scale: 1 - animation.value),
          child: child,
        ),
      ],
    );
  }
}

class Caliper extends CustomClipper<Path> {
  final double scale;
  Caliper({required this.scale});
  @override
  getClip(Size size) {
    double cW, cH, wU, hU;
    cW = (size.width / 2);
    cH = (size.height / 2);
    wU = (min(size.width, size.height) * 2) -
        (min(size.width, size.height) * 2 * scale);

    Path path = Path();
    //
    path.moveTo(cW, cH - wU); // center -|
    //
    // path.lineTo(cW + (cW / 2), cH - (cW / 2)); // corner >
    //
    path.quadraticBezierTo(
      cW + (wU),
      cH - (wU),
      cW + (wU),
      cH,
    ); // center -|
    //
    // path.lineTo(cW + (cW / 2), cH + (cW / 2)); // corner >
    //
    path.quadraticBezierTo(
      cW + (wU),
      cH + (wU),
      cW,
      cH + (wU),
    ); // center -|
    //
    // path.lineTo(cW - (cW / 2), cH + (cW / 2)); // corner >
    //
    path.quadraticBezierTo(
      cW - (wU),
      cH + (wU),
      cW - (wU),
      cH,
    ); // center -|
    //
    // path.lineTo(cW - (cW / 2), cH - (cW / 2)); // corner >
    //
    path.quadraticBezierTo(
      cW - (wU),
      cH - (wU),
      cW,
      cH - (wU),
    ); // center -|
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper oldClipper) {
    return true;
  }
}
