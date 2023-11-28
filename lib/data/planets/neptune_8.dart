import 'package:flutter/material.dart';
import 'package:planets/classes/planet.dart';
import 'package:planets/helpers/assets_path.dart';

Planet neptune = Planet(
  //----------------------------------------------------------------------------
  info: PlanetInfo(
    order: 8,
    name: "Neptune",
        color: const Color(0xff693B94),
    description: "Neptune is the eighth and farthest planet from the Sun. It is an ice giant made up mostly of hydrogen, helium, and methane. Neptune has a very strong magnetic field and a Great Dark Spot, a giant storm that is similar to Jupiter's Great Red Spot. It has 14 known moons, the largest of which is Triton. It orbits the Sun once every 164.79 Earth years.",
  ),
  //----------------------------------------------------------------------------
  properties: PlanetProperties(
    gravity: 11,
    distanceFrmEarth: 4311.02,
    distanceFrmSun: 4495.1,
    diameter: 49528,
  ),
  //----------------------------------------------------------------------------
  assets: PLanetAssets(
    planet: (PlanetsAssetsPaths.neptuneP),
    plntLayer: (PlanetsAssetsPaths.neptuneL),
    sound: "",
  ),
  //----------------------------------------------------------------------------
);
