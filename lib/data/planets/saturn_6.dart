import 'package:flutter/material.dart';
import 'package:planets/classes/planet.dart';
import 'package:planets/helpers/assets_path.dart';

Planet saturn = Planet(
  //----------------------------------------------------------------------------
  info: PlanetInfo(
    order: 6,
    name: "Saturn",
        color: const Color(0xffF89C1A),
    description: "Saturn is the sixth planet from the Sun and the second largest planet in our solar system. It is a gas giant made up mostly of hydrogen and helium. Saturn is known for its beautiful rings, which are made up of ice and rock particles. It has 62 known moons, including the largest moon in our solar system, Titan. It orbits the Sun once every 29.46 Earth years.",
  ),
  //----------------------------------------------------------------------------
  properties: PlanetProperties(
    gravity: 9.0,
    distanceFrmEarth: 1204.28,
    distanceFrmSun: 1433.5,
    diameter: 120536,
  ),
  //----------------------------------------------------------------------------
  assets: PLanetAssets(
    planet: (PlanetsAssetsPaths.saturnP),
    plntLayer: (PlanetsAssetsPaths.saturnL),
    sound: "",
  ),
  //----------------------------------------------------------------------------
);
