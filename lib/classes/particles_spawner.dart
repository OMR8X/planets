import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:planets/helpers/colors_h.dart';

class ParticlesSpawner {
  // particles count
  late int count;
  // particles count
  double speed = 1.0;
  // size of screen
  late Size size;
  // where to spawn particles
  late Offset spawningOffset;
  // particles
  late List<Particle> particles;
  //
  ParticlesSpawner({
    required this.count,
    required this.speed,
    required this.spawningOffset,
    required this.size,
  }) {
    particles = [];
  }
  //
  onInitialize() {
    for (int i = 0; i < 500; i++) {
      addParticles();
    }
  }

  addParticles() {
    particles.add(Particle(
      offset: spawningOffset,
      distance: 150 * Random().nextDouble(),
      radius: 5.0 + Random().nextInt(15),
      direction: Direction(dx: -0.3 + (0.6 * Random().nextDouble()), dy: 1),
      onDelete: (Offset pOffset) {
        particles.removeWhere((p) => p.offset == pOffset);
        addParticles();
      },
    ));
  }

  onUpdate(Offset newOffset, double speed) {
    spawningOffset = newOffset;
    // change every single particle offset.
    for (int i = 0; i < particles.length; i++) {
      particles[i].update(speed: speed);
    }
  }
}

class Particle {
  // moving amount per second
  late double dx, dy, speed;
  // particles offset
  late Offset offset;
  // particles offset
  late Offset oldOffset;
  // full moving amount
  late double distance;
  // particle radius
  late double radius;
  // moving direction
  late Direction direction;
  // when moving ends
  late Function(Offset) onDelete;
  //
  Particle({
    required this.offset,
    required this.distance,
    required this.radius,
    required this.direction,
    required this.onDelete,
  }) {
    oldOffset = offset;
    speed = 1.0;
    dx = 0.0;
    dy = 0.0;
  }
  update({double? speed}) {
    if (speed != null) {
      this.speed = speed;
    }
    if (offset.getDistance(oldOffset) <= distance * ((1.2 - this.speed))) {
      updateOffset();
    } else {
      onDelete(offset);
    }
  }

  Curve curve = Curves.bounceIn;
  updateOffset() {
    dx += ((1 / 60));
    dy += ((1 / 60));
    offset = Offset(
      offset.dx + ((((dx)) * (distance)) * direction.dx) * (1.1 - speed),
      offset.dy + ((((dy)) * (distance)) * direction.dy) * (1.1 - speed),
    );
    radius -= radius / 10;
  }

  getOpacity() {
    double opacity = 1.0;
    opacity = (offset.getDistance(oldOffset) / distance);
    opacity = opacity > 1 ? 1 : opacity;
    opacity = opacity < 0.01 ? 0.01 : opacity;
    return 1.0 - opacity;
  }

  // getAnimationValue(double x) {
  //   return pow(x, 0.4).toDouble();
  // }
}

class Direction {
  final double dx, dy;
  const Direction({required this.dx, required this.dy});
}

class ParticlesSpawnerPainter extends CustomPainter {
  final List<Particle> particles;

  const ParticlesSpawnerPainter({required this.particles});
  @override
  void paint(Canvas canvas, Size size) {
    for (var p in particles) {
      drawParticle(canvas, p);
    }
  }

  void drawParticle(Canvas canvas, Particle particle) {
    Paint paint = Paint();
    double opacity = particle.getOpacity();
    paint.color =
        Color.lerp(ColorsHelper.particle(opacity), Colors.red, opacity)!;
    canvas.drawCircle(particle.offset, particle.radius, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

extension Distance on Offset {
  double getDistance(Offset offset) {
    double x1, x2, y1, y2;
    x1 = dx;
    x2 = offset.dx;
    y1 = dy; 
    y2 = offset.dy;
    double output = (x2 - x1).abs() + (y2 - y1).abs();
    return output;
  }
}
