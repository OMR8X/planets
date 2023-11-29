import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:planets/classes/planet.dart';
import 'package:planets/classes/sounds_manager.dart';
import 'package:planets/helpers/assets_path.dart';
import 'package:planets/helpers/colors_h.dart';
import 'package:planets/layers/stars_layer.dart';
import 'package:planets/views/planet_view.dart';
import 'package:planets/views/planets_picking_view.dart';

class SimulationView extends StatefulWidget {
  const SimulationView({super.key, required this.planet});
  final Planet planet;
  @override
  State<SimulationView> createState() => _SimulationViewState();
}

class _SimulationViewState extends State<SimulationView> {
  late Timer _timer;
  ValueNotifier<Offset> offset = ValueNotifier(Offset.zero);
  Size size = Size.zero;
  bool gripping = false;
  bool spawn = false;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        size = MediaQuery.sizeOf(context);
        offset.value = Offset((size.width / 2) - 20, (size.height / 2) - 20);
        size = Size((size.width / 2) - 20, (size.height / 2) - 20);
      });
    });

    _timer = Timer.periodic(
      const Duration(milliseconds: 60 ~/ 1000),
      (timer) {
        updateOffset();
      },
    );
    SoundsManager().stopEffect();
    SoundsManager().stopRocket();
    super.initState();
  }

  updateOffset() {
    if (gripping) return;
    if (!mounted) return;
    Offset direction = Offset(
      ((((size.width)) - offset.value.dx)),
      ((((size.height)) - offset.value.dy)),
    );
    direction = Offset(direction.dx / size.width, direction.dy / size.height);
    if (direction.dx.abs() < 0.00001 && direction.dy.abs() < 0.00001) return;
    setState(() {
      offset.value = Offset(
          offset.value.dx +
              (direction.dx / (10000) * widget.planet.properties.gravity),
          offset.value.dy +
              (direction.dy / (10000) * widget.planet.properties.gravity));
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: Stack(
        children: [
          StarsLayerWidget(size: MediaQuery.sizeOf(context)),

          Align(
            alignment: const Alignment(0, 0),
            child: SizedBox(
              width: size.width - 25,
              height: size.width - 25,
              child: Transform.scale(
                scale: 0.5,
                child: PlanetWidget(
                  planet: widget.planet,
                  showLayer2: false,
                ),
              ),
            ),
          ),
          RocketParticlesPainterWidget(
            spawn: spawn,
            rocketOffset: offset,
            size: CanvasInfo.canvasSize(context),
          ),
          Transform.translate(
            offset: offset.value,
            child: SvgPicture.asset(
              AssetsPaths.rock,
              width: 40,
            ),
          ),

          GestureDetector(
            onPanDown: (details) {
              gripping = true;
            },
            onPanUpdate: (details) {
              spawn = true;
              setState(() {
                offset.value = Offset(
                  details.globalPosition.dx - 20,
                  details.globalPosition.dy - 20,
                );
              });
            },
            onPanEnd: (details) {
              spawn = false;
              gripping = false;
            },
            child: Container(
              color: Colors.transparent,
            ),
          ),
          // App Bar
          const SafeArea(child: AppBarWidget()),
        ],
      ),
    );
  }
}

class Vector2 {
  double dX, dY;
  Vector2({required this.dX, required this.dY});
}

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
///
class RocketParticlesPainterWidget extends StatelessWidget {
  const RocketParticlesPainterWidget({
    super.key,
    required this.rocketOffset,
    required this.size,
    required this.spawn,
  });
  final ValueNotifier<Offset> rocketOffset;
  final Size size;
  final bool spawn;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ValueListenableBuilder(
          valueListenable: rocketOffset,
          builder: (context, value, child) {
            return PainterWidget(
              spawn: spawn,
              rocketOffset: value,
              size: size,
            );
          }),
    );
  }
}

class PainterWidget extends StatefulWidget {
  final Offset rocketOffset;
  final Size size;
  final bool spawn;
  const PainterWidget({
    super.key,
    required this.rocketOffset,
    required this.size,
    required this.spawn,
  });

  @override
  State<PainterWidget> createState() => _PainterWidgetState();
}

class _PainterWidgetState extends State<PainterWidget> {
  List<RocketFireParticle> particles = [];
  late Timer _lisnter;
  late Timer _updater;
  final int time = 1000 ~/ 60;
  bool spawn = false;
  @override
  void initState() {
    // createParticles();
    _updater = Timer.periodic(
      Duration(milliseconds: time),
      (timer) {
        onUpdate();
      },
    );
    _lisnter = Timer.periodic(
      const Duration(milliseconds: 50),
      (timer) {
        if (spawn) {
          addParticle();
        }
      },
    );
    super.initState();
  }

  onUpdate() {
    if (!mounted) return;
    setState(() {
      for (int i = 0; i < particles.length; i++) {
        particles[i].onUpdate();
      }
    });
  }

  addParticle() {
    Offset currentOffset = CanvasInfo.rocketParticlesSpawnOffset(
      widget.size,
      widget.rocketOffset,
    );
    particles.add(RocketFireParticle(
      offset: currentOffset,
      seconds: 1.0 + Random().nextInt(2),
      distance: (50 * Random().nextDouble()),
      direction: Offset(
        -1 + (2 * Random().nextDouble()),
        -1 + (2 * Random().nextDouble()),
      ),
      onDelete: (p0) {
        particles.removeWhere((e) => e.offset == p0);
      },
      color: Random().nextBool() ? ColorsHelper.meteor1 : ColorsHelper.meteor2,
      radius: 1.0 + Random().nextInt(8),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CustomPaint(
        painter: RocketFireParticlesPainter(particles: particles),
      ),
    );
  }

  @override
  void didUpdateWidget(covariant PainterWidget oldWidget) {
    setState(() {
      spawn = widget.spawn;
    });
    super.didUpdateWidget(oldWidget);
  }
}

class RocketFireParticle {
  // values
  double seconds;
  Offset offset;
  double distance;
  Offset direction;
  // style
  Color color;
  double radius;
  Function(Offset) onDelete;
  //
  late Offset oldOffset;
  late double oldRadius;
  onUpdate() {
    double dstBetween = getDistance();
    if (dstBetween < distance) {
      // update offset
      offset = Offset(
        offset.dx + ((distance * direction.dx) / (60 * seconds)),
        offset.dy + ((distance * direction.dy) / (60 * seconds)),
      );
      // updateRadius
      radius = (1.01 - (dstBetween / distance)) * oldRadius;
    } else {
      onDelete(offset);
    }
    //
  }

  double getDistance() {
    double dx, dy, res;
    dx = (offset.dx - oldOffset.dx).abs();
    dy = (offset.dy - oldOffset.dy).abs();
    res = (dx + dy);
    return res < 0.01 ? 0.01 : res;
  }

  //
  RocketFireParticle({
    required this.seconds,
    required this.offset,
    required this.distance,
    required this.direction,
    required this.color,
    required this.radius,
    required this.onDelete,
  }) {
    oldOffset = offset;
    oldRadius = radius;
  }
}

class RocketFireParticlesPainter extends CustomPainter {
  final List<RocketFireParticle> particles;

  RocketFireParticlesPainter({required this.particles});

  @override
  void paint(Canvas canvas, Size size) {
    for (var p in particles) {
      drawParticle(canvas, size, p);
    }
  }

  void drawParticle(Canvas canvas, Size size, RocketFireParticle p) {
    //
    canvas.drawCircle(
      Offset(p.offset.dx, p.offset.dy),
      p.radius,
      paintStyle(p),
    );
  }

  paintStyle(RocketFireParticle p) {
    // create paint
    Paint paint = Paint();
    //
    double distance = p.getDistance();
    // Color
    paint.color = (Color.lerp(
          p.color,
          ColorsHelper.meteor2.withOpacity(0),
          distance / p.distance,
        ) ??
        Colors.red);
    //
    return paint;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class GesturesDetectingWidget extends StatelessWidget {
  const GesturesDetectingWidget({
    super.key,
    this.rocketOffset,
    this.onPanEnd,
  });
  final Function(Offset)? rocketOffset;
  final void Function(DragEndDetails)? onPanEnd;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onPanDown: (details) {
          sendRocketOffset(details.localPosition);
        },
        onPanUpdate: (details) {
          sendRocketOffset(details.localPosition);
        },
        onPanEnd: onPanEnd,
      ),
    );
  }

  sendRocketOffset(Offset o) {
    if (rocketOffset == null) return;
    double height = Settings.rocketHeight / 2;
    double width = Settings.rocketWidth / 2;
    rocketOffset!(Offset(o.dx - width, o.dy - height));
  }
}

class Settings {
  static const double rocketHeight = 100;
  static double get rocketWidth => rocketHeight * 0.37;
}

class CanvasInfo {
  static rocketParticlesSpawnOffset(Size size, Offset touch) {
    //
    double w, h, dstFromBottom = Settings.rocketHeight / 10;
    //
    w = touch.dx + (Settings.rocketWidth / 2) - (size.width / 2);
    h = touch.dy - (size.height / 2);
    //
    return Offset(w, h);
  }

  static Size canvasSize(BuildContext context) {
    double w, h;
    var media = MediaQuery.of(context);
    w = media.size.width - media.padding.horizontal;
    h = media.size.height - media.padding.vertical;
    return Size(w, h);
  }
}
