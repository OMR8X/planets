import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:planets/classes/planet.dart';
import 'package:planets/classes/sounds_manager.dart';
import 'package:planets/classes/space_page_route.dart';
import 'package:planets/data/planets/earth_3.dart';
import 'package:planets/data/planets/jupiter_5.dart';
import 'package:planets/data/planets/mars_4.dart';
import 'package:planets/data/planets/mercury_1.dart';
import 'package:planets/data/planets/neptune_8.dart';
import 'package:planets/data/planets/saturn_6.dart';
import 'package:planets/data/planets/sun_0.dart';
import 'package:planets/data/planets/uranus_7.dart';
import 'package:planets/data/planets/venus_2.dart';
import 'package:planets/helpers/assets_path.dart';
import 'package:planets/layers/meteorite_layer.dart';
import 'package:planets/layers/stars_layer.dart';
import 'package:planets/views/planet_view.dart';

class PlanetsPickingView extends StatefulWidget {
  const PlanetsPickingView({super.key});

  @override
  State<PlanetsPickingView> createState() => _PlanetsPickingViewState();
}

class _PlanetsPickingViewState extends State<PlanetsPickingView> {
  Planet currentPlanet = sun;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          StarsLayerWidget(size: MediaQuery.sizeOf(context)),
          const MeteoriteLayer(),
          PlanetPickerWidget(
            onPickPlanet: (p0) {
              setState(() {
                currentPlanet = p0;
              });
            },
          ),
          Align(
              alignment: const Alignment(0, 0.9),
              child: SizedBox(
                width: MediaQuery.sizeOf(context).width - 35,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text(
                          "Back",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: currentPlanet.info.color),
                        onPressed: () {
                          Navigator.of(context).push(SpacePageRoute(
                              page: PlanetView(
                            planet: currentPlanet,
                          )));
                        },
                        child: Text(
                          "Go To ${currentPlanet.info.name}",
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ))
        ],
      ),
    );
  }
}

class PlanetPickerWidget extends StatefulWidget {
  const PlanetPickerWidget({
    super.key,
    required this.onPickPlanet,
  });
  final Function(Planet) onPickPlanet;
  @override
  State<PlanetPickerWidget> createState() => _PlanetPickerWidgetState();
}

class _PlanetPickerWidgetState extends State<PlanetPickerWidget> {
  PageController controller = PageController(viewportFraction: 0.5);
  List<Planet> planets = [
    sun,
    mercury,
    venus,
    earth,
    mars,
    jupiter,
    saturn,
    uranus,
    neptune,
  ];
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  double changeOffset(int index, double offset) {
    if ((index - offset).abs() < 1.01 && (offset - index).abs() < 1.01) {
      return (offset - index >= -0.5 && offset - index <= 0.5) ? 1.5 : 0.5;
    }
    return 0.5;
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: controller,
      itemCount: planets.length,
      onPageChanged: (value) {
        SoundsManager().pageChange();
        widget.onPickPlanet(planets[value]);
      },
      itemBuilder: (context, index) {
        return AnimatedBuilder(
          animation: controller,
          builder: (context, child) {
            double pageOffset = 0.0;
            if (controller.position.haveDimensions) {
              pageOffset = controller.page!;
            }

            return AnimatedScale(
              duration: const Duration(milliseconds: 250),
              scale: changeOffset(index, pageOffset),
              child: PlanetWidget(planet: planets[index]),
            );
          },
        );
      },
    );
  }
}

class PlanetWidget extends StatelessWidget {
  const PlanetWidget({super.key, required this.planet, this.showLayer2 = true});
  final Planet planet;
  final bool showLayer2;
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SvgPicture.asset(
          planet.assets.planet,
          width: MediaQuery.sizeOf(context).width,
        ),
        if (planet.assets.plntLayer != null && showLayer2)
          SvgPicture.asset(
            planet.assets.plntLayer!,
            width: MediaQuery.sizeOf(context).width,
          ),
      ],
    );
  }
}
