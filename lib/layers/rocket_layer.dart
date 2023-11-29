import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:planets/classes/particles_spawner.dart';
import 'package:planets/classes/sounds_manager.dart';
import 'package:planets/helpers/assets_path.dart';

class RocketLayerWidget extends StatefulWidget {
  const RocketLayerWidget({
    super.key,
    required this.size,
    required this.fly,
    required this.seconds,
    required this.onAnimationEnd,
  });
  final Size size;
  final bool fly;
  final int seconds;
  final VoidCallback onAnimationEnd;
  @override
  State<RocketLayerWidget> createState() => _RocketLayerWidgetState();
}

class _RocketLayerWidgetState extends State<RocketLayerWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;
  late ParticlesSpawner spawner;
  double speed = 1.0;

  @override
  void initState() {
    SoundsManager().stopRocket();
    SoundsManager().playRocket1();
    initializeAnimation();
    initializeParticlesSpawner();
    controller.addStatusListener((status) {
      // SoundsManager().stopRocket();
      // SoundsManager().playRocket1();
      if (status == AnimationStatus.dismissed) {
        widget.onAnimationEnd();
        SoundsManager().setRocketVolume(0.0);
      }
      if (status == AnimationStatus.forward) {
        SoundsManager().setRocketVolume(0.85);
        SoundsManager().playRocket1();
      }
      if (status == AnimationStatus.reverse) {
        SoundsManager().setRocketVolume(0.85);
        SoundsManager().playRocket1();
      }
      if (status == AnimationStatus.completed) {}
    });
    super.initState();
  }

  initializeParticlesSpawner() { 
    spawner = ParticlesSpawner(
      count: 20,
      speed: 1.0,
      spawningOffset: getRocketOffset(),
      size: widget.size,
    );
    spawner.onInitialize();
    Timer.periodic(
      const Duration(milliseconds: 1000 ~/ 60),
      (timer) {
        if (mounted) {
          spawner.onUpdate(getRocketOffset(), speed);
          setState(() {});
        }
      },
    );
  }

  Offset getRocketOffset() {
    double fullDist = 1.9;
    double currentDist = 0.0;
    if (animation.value < 0.0) {
      currentDist = 1.5 - animation.value.abs();
    } else {
      currentDist = animation.value + 1.5;
    }
    speed = (currentDist / fullDist);

    return Offset(
      widget.size.width / 2,
      (currentDist / fullDist) * (widget.size.height / 4.1 * 3),
    );
  }

  initializeAnimation() {
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: widget.seconds),
    );
    animation = Tween<double>(begin: -1.9, end: 0.4).animate(
      CurvedAnimation(parent: controller, curve: Curves.decelerate),
    );
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    if (animation.value > 0) {
      SoundsManager().setRocketVolume(0.85 - animation.value);
    }

    return AnimatedBuilder(
        animation: controller,
        builder: (context, child) {
          return Stack(
            children: [
              CustomPaint(
                painter: ParticlesSpawnerPainter(particles: spawner.particles),
              ),
              Align(
                alignment: Alignment(0, animation.value),
                child: RocketWidget(
                  size: widget.size,
                ),
              ),
            ],
          );
        });
  }

  @override
  void didUpdateWidget(covariant RocketLayerWidget oldWidget) {
    if (widget.fly && controller.status == AnimationStatus.completed) {
      controller.reverse();
    } else if (!widget.fly && controller.status == AnimationStatus.dismissed) {
      controller.forward();
    }
    super.didUpdateWidget(oldWidget);
  }
}

class RocketWidget extends StatelessWidget {
  const RocketWidget({
    super.key,
    required this.size,
  });
  final Size size;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size.height / 4,
      width: size.height / 4,
      child: SvgPicture.asset(
        AssetsPaths.rocket,
      ),
    );
  }
}
