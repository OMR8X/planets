import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:planets/classes/planet.dart';
import 'package:planets/helpers/assets_path.dart';
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
  Offset offset = Offset.zero;
  Size size = Size.zero;
  bool gripping = false;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        size = MediaQuery.sizeOf(context);
        offset = Offset((size.width / 2) - 20, (size.height / 2) - 20);
        size = Size((size.width / 2) - 20, (size.height / 2) - 20);
      });
    });

    _timer = Timer.periodic(
      const Duration(milliseconds: 60 ~/ 1000),
      (timer) {
        updateOffset();
      },
    );
    super.initState();
  }

  updateOffset() {
    if (gripping) return;
    if (!mounted) return;
    Offset direction = Offset(
      ((((size.width)) - offset.dx)),
      ((((size.height)) - offset.dy)),
    );
    direction = Offset(direction.dx / size.width, direction.dy / size.height);
    if (direction.dx.abs() < 0.00001 && direction.dy.abs() < 0.00001) return;
    setState(() {
      offset = Offset(
          offset.dx +
              (direction.dx / (10000) * widget.planet.properties.gravity),
          offset.dy +
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
          Transform.translate(
            offset: offset,
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
              setState(() {
                offset = Offset(
                  details.globalPosition.dx - 20,
                  details.globalPosition.dy - 20,
                );
              });
            },
            onPanEnd: (details) {
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
