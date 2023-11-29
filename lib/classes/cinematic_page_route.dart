import 'package:flutter/material.dart';

class CinematicRoute extends PageRouteBuilder {
  final Widget page;
  CinematicRoute({required this.page})
      : super(
            transitionDuration: const Duration(milliseconds: 900),
            reverseTransitionDuration: const Duration(milliseconds: 900),
            pageBuilder: (context, animation, secondaryAnimation) => page);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return FadeTransition(
      opacity: animation,
      child: page,
    );
  }
}
