import 'package:flutter/material.dart';
import 'package:planets/classes/planet.dart';
import 'package:planets/helpers/assets_path.dart';

Planet mercury = Planet(
  //----------------------------------------------------------------------------
  info: PlanetInfo(
    order: 1,
    name: "Mercury",
        color: const Color(0xff646365),
    description: "Mercury is the smallest and innermost planet in our solar system. It is also the closest planet to the Sun. Mercury has a very thin atmosphere and a rocky surface. It is also the fastest planet in our solar system, orbiting the Sun once every 88 Earth days.",
  ),
  //----------------------------------------------------------------------------
  properties: PlanetProperties(
    gravity: 3.7,
    distanceFrmEarth: 82.5,
    distanceFrmSun: 57.9,
    diameter: 4879,
  ),
  //----------------------------------------------------------------------------
  assets: PLanetAssets(
    planet: (PlanetsAssetsPaths.mercuryP),
    sound: "",
  ),
  //----------------------------------------------------------------------------
);
