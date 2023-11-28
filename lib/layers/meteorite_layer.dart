import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:planets/helpers/assets_path.dart';

class MeteoriteLayer extends StatefulWidget {
  const MeteoriteLayer({super.key});

  @override
  State<MeteoriteLayer> createState() => _MeteoriteLayerState();
}

class _MeteoriteLayerState extends State<MeteoriteLayer>
    with TickerProviderStateMixin {
  late AnimationController controller;
  late Animation<Alignment> meteoriteAnimation;

  void restartAnimation() {
    if (mounted) {
      controller.forward(from: 0.0);
    }
  }

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2300),
    )..forward();
    initializeAnimations();
    controller.addStatusListener((status) {
      if (status == AnimationStatus.completed &&
          !controller.isAnimating &&
          mounted) {
        Future.delayed(Duration(seconds: 5 + Random().nextInt(10)), () {
          initializeAnimations();
          restartAnimation();
        });
      }
    });
    super.initState();
  }

  initializeAnimations() {
    if (!mounted) return;
    double amount = Random().nextDouble() * 4 - 2;
    meteoriteAnimation = Tween<Alignment>(
      begin: Alignment(-1.5, -1.5 + (amount)),
      end: Alignment(1.5, 1.5 + (amount)),
    ).animate(controller);
    setState(() {});
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: MediaQuery.sizeOf(context).width,
        height: MediaQuery.sizeOf(context).width,
        child: AlignTransition(
            alignment: meteoriteAnimation,
            child: Opacity(
              opacity: 0.7,
              child: SvgPicture.asset(
                AssetsPaths.meteoriteRed,
                width: 20,
                colorFilter: const ColorFilter.mode(
                  Colors.white,
                  BlendMode.srcIn,
                ),
              ),
            )),
      ),
    );
  }
}
