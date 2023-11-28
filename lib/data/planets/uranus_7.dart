import 'package:flutter/material.dart';
import 'package:planets/classes/planet.dart';
import 'package:planets/helpers/assets_path.dart';

Planet uranus = Planet(
  //----------------------------------------------------------------------------
  info: PlanetInfo(
    order: 7,
    name: "Uranus",
        color: const Color(0xff30479B),
    description: "Uranus is the seventh planet from the Sun and the third largest planet in our solar system. It is an ice giant made up mostly of hydrogen, helium, and methane. Uranus has a very weak magnetic field and a system of rings. It has 27 known moons, the largest of which is Miranda. It orbits the Sun once every 84.01 Earth years.",
  ),
  //----------------------------------------------------------------------------
  properties: PlanetProperties(
    gravity: 8.7,
    distanceFrmEarth: 2586.88,
    distanceFrmSun: 2872.5,
    diameter: 51118,
  ),
  //----------------------------------------------------------------------------
  assets: PLanetAssets(
    planet: (PlanetsAssetsPaths.uranusP),
    plntLayer: (PlanetsAssetsPaths.uranusL),
    sound: "",
  ),
  //----------------------------------------------------------------------------
);
