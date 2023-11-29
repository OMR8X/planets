import 'package:flutter/material.dart';
import 'package:planets/classes/planet.dart';
import 'package:planets/classes/sounds_manager.dart';
import 'package:planets/classes/space_page_route.dart';
import 'package:planets/helpers/colors_h.dart';
import 'package:planets/layers/gradient_layer.dart';
import 'package:planets/layers/meteorite_layer.dart';
import 'package:planets/layers/stars_layer.dart';
import 'package:planets/views/planets_picking_view.dart';
import 'package:planets/views/simulation_view.dart';

class PlanetView extends StatefulWidget {
  const PlanetView({super.key, required this.planet});
  final Planet planet;
  @override
  State<PlanetView> createState() => _PlanetViewState();
}

class _PlanetViewState extends State<PlanetView> with TickerProviderStateMixin {
  late AnimationController controller;
  late Animation<Offset> transAnimation;
  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 750),
    )..forward();
    transAnimation = Tween<Offset>(
      begin: const Offset(0, 0.1),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: controller, curve: Curves.decelerate));
    SoundsManager().stopEffect();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          StarsLayerWidget(size: MediaQuery.sizeOf(context)),
          const MeteoriteLayer(),
          const GradientLayer(),
          SingleChildScrollView(
            child: Column(
              children: [
                // Padding
                SizedBox(height: MediaQuery.of(context).padding.top),
                // App Bar
                const AppBarWidget(),
                // Planet
                SlideTransition(
                    position: transAnimation,
                    child: PlanetWidget(planet: widget.planet)),
                const SizedBox(height: 20),
                // Content
                SlideTransition(
                  position: transAnimation,
                  child: Content(
                    planet: widget.planet,
                  ),
                ),
                // button
                SizedBox(
                  width: MediaQuery.sizeOf(context).width - 40,
                  child: SlideTransition(
                    position: transAnimation,
                    child: ElevatedButton(
                      onPressed: () {
                        SoundsManager().stopBackGround();
                        SoundsManager().playSpace2();
                        Navigator.of(context)
                            .push(
                          SpacePageRoute(
                            page: SimulationView(planet: widget.planet),
                          ),
                        )
                            .then((value) {
                          SoundsManager().stopSpace();
                          SoundsManager().playBackground();
                        });
                      },
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            "Simulate Gravity ",
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                //
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Content extends StatelessWidget {
  const Content({
    super.key,
    required this.planet,
  });

  final Planet planet;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: MediaQuery.sizeOf(context).width - 35,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                planet.info.name,
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: planet.info.color,
                  fontSize: 40,
                  height: 0.9,
                  fontWeight: FontWeight.w200,
                ),
              ),
              const SizedBox(width: 5),
              Text(
                "${planet.info.order}th",
                style: const TextStyle(
                  color: Colors.white60,
                  fontSize: 24,
                  height: 1,
                  fontWeight: FontWeight.w100,
                ),
              ),
            ],
          ),
        ),
        // space (font size * 1.3)
        const SizedBox(height: 40 * 0.3),
        // description
        SizedBox(
          width: MediaQuery.sizeOf(context).width - 40,
          child: Column(
            children: [
              Row(
                children: [
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width - 40,
                    child: Text(
                      planet.info.description,
                      textAlign: TextAlign.start,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        height: 1.2,
                        wordSpacing: 1.2,
                        fontWeight: FontWeight.w100,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        // space (font size * 1.3)
        const SizedBox(height: 40 * 0.3),
        // properties
        SizedBox(
          width: MediaQuery.sizeOf(context).width - 40,
          child: Column(
            children: [
              PropertiesUnitWidget(
                  t1: "Gravity",
                  t2: "${planet.properties.gravity}",
                  t3: "M/S²"),
              PropertiesUnitWidget(
                  t1: "Distance From Earth",
                  t2: "${planet.properties.distanceFrmEarth}",
                  t3: "  KM"),
              PropertiesUnitWidget(
                  t1: "Distance From Sun",
                  t2: "${planet.properties.distanceFrmSun}",
                  t3: "  KM"),
              PropertiesUnitWidget(
                  t1: "Diameter",
                  t2: "${planet.properties.diameter}",
                  t3: "  KM"),
              // space (font size * 1.3)
              const SizedBox(height: 40 * 0.3),
            ],
          ),
        ),
      ],
    );
  }
}

class AppBarWidget extends StatelessWidget {
  const AppBarWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: MediaQuery.sizeOf(context).width - 25,
          child: Row(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Container(
                    padding: const EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: Colors.white,
                      ),
                    ),
                    child: const Icon(Icons.arrow_back_ios_new_outlined)),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class PropertiesUnitWidget extends StatelessWidget {
  const PropertiesUnitWidget(
      {super.key, required this.t1, required this.t2, required this.t3});
  final String t1, t2, t3;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width - 40,
      child: Row(
        children: [
          Text(
            t1,
            textAlign: TextAlign.start,
            style: const TextStyle(
              color: Colors.white54,
              fontSize: 16,
              height: 1.3,
              fontWeight: FontWeight.w200,
            ),
          ),
          //
          const SizedBox(width: 4),
          const Expanded(
            child: Text(
              "............................................................................................",
              maxLines: 1,
              overflow: TextOverflow.clip,
              style: TextStyle(
                color: Colors.white24,
                fontSize: 12,
                height: 1,
                fontWeight: FontWeight.w100,
              ),
            ),
          ),
          const SizedBox(width: 4),
          //
          Text(
            t2,
            textAlign: TextAlign.start,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 16,
              height: 1.3,
              fontWeight: FontWeight.w200,
            ),
          ),
          const SizedBox(width: 5),
          Text(
            t3,
            textAlign: TextAlign.start,
            style: const TextStyle(
              color: Colors.white38,
              fontSize: 16,
              height: 1.3,
              letterSpacing: 0,
              fontWeight: FontWeight.w100,
            ),
          ),
        ],
      ),
    );
  }
}
