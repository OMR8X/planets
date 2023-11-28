import 'package:flutter/material.dart';
import 'package:planets/classes/planet.dart';
import 'package:planets/helpers/assets_path.dart';

Planet jupiter = Planet(
  //----------------------------------------------------------------------------
  info: PlanetInfo(
    order: 5,
    name: "Jupiter",
    color: const Color(0xffA88236),
    description: "Jupiter is the fifth planet from the Sun and the largest planet in our solar system. It is a gas giant made up mostly of hydrogen and helium. Jupiter has a very strong magnetic field and a Great Red Spot, a giant storm that has been raging for hundreds of years. It has 50 known moons, including the four Galilean moons: Io, Europa, Ganymede, and Callisto. It orbits the Sun once every 11.86 Earth years.",
  ),
  //----------------------------------------------------------------------------
  properties: PlanetProperties(
    gravity: 23.1,
    distanceFrmEarth: 591.97,
    distanceFrmSun: 778.6,
    diameter: 142984,
  ),
  //----------------------------------------------------------------------------
  assets: PLanetAssets(
    planet: (PlanetsAssetsPaths.jupiterP),
    plntLayer: (PlanetsAssetsPaths.jupiterL),
    sound: "",
  ),
  //----------------------------------------------------------------------------
);
