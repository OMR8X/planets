import 'dart:math';

import 'package:flutter/material.dart';
import 'package:planets/classes/sounds_manager.dart';
import 'package:planets/classes/space_page_route.dart';
import 'package:planets/layers/land_layer.dart';
import 'package:planets/layers/meteorite_layer.dart';
import 'package:planets/layers/rocket_layer.dart';
import 'package:planets/layers/stars_layer.dart';
import 'package:planets/views/planets_picking_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late Size size;
  int animationDurationINSeconds = 6;
  bool fly = false;
  @override
  void initState() {
    SoundsManager().orchestra();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.sizeOf(context);
    return Scaffold(
        body: Stack(
      children: [
        StarsLayerWidget(size: size),
        const MeteoriteLayer(),
        LandLayerWidget(size: size),
        RocketLayerWidget(
          size: size,
          fly: fly,
          seconds: animationDurationINSeconds,
          onAnimationEnd: () {
            Navigator.of(context)
                .push(SpacePageRoute(page: const PlanetsPickingView()))
                .then((value) => setState(() => fly = false));
          },
        ),
        TweenAnimationBuilder(
            duration: const Duration(seconds: 6),
            curve: Curves.easeInExpo,
            tween: Tween<double>(begin: 1.2, end: fly ? 1.2 : 0.9),
            builder: (context, value, widget) {
              return Align(
                alignment: Alignment(0, value),
                child: SizedBox(
                  width: MediaQuery.sizeOf(context).width - 35,
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        fly = !fly;
                      });
                    },
                    child: const Text(
                      "Fly",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              );
            }),
      ],
    ));
  }
}
