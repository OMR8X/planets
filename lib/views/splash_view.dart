import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:planets/classes/cinematic_page_route.dart';
import 'package:planets/helpers/assets_path.dart';
import 'package:planets/views/home_view.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  late Timer _timer;
  @override
  void initState() {
    _timer = Timer(const Duration(seconds: 4), () {
      Navigator.of(context).push(CinematicRoute(page: const HomeView()));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const Spacer(),
            TweenAnimationBuilder<double>(
              tween: Tween<double>(begin: 0, end: 1),
              duration: const Duration(milliseconds: 1000),
              builder: (context, v, w) {
                return Opacity(
                  opacity: v,
                  child: const Text(
                    "Space App",
                    style: TextStyle(fontSize: 40),
                  ),
                );
              },
            ),
            const Spacer(),
            TweenAnimationBuilder<double>(
              tween: Tween<double>(begin: 0, end: 1),
              duration: const Duration(milliseconds: 2000),
              builder: (context, v, w) {
                return Opacity(
                  opacity: v,
                  child: const Text(
                    "BY",
                    style: TextStyle(fontSize: 16),
                  ),
                );
              },
            ),
            const SizedBox(height: 4),
            TweenAnimationBuilder<double>(
              tween: Tween<double>(begin: 0, end: 1),
              duration: const Duration(milliseconds: 2000),
              builder: (context, v, w) {
                return Opacity(
                  opacity: v,
                  child: const Text(
                    "@OMR8X",
                    style: TextStyle(fontSize: 16),
                  ),
                );
              },
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
