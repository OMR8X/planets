import 'package:flutter/material.dart';
import 'package:planets/classes/planet.dart';
import 'package:planets/helpers/assets_path.dart';

Planet sun = Planet(
  //----------------------------------------------------------------------------
  info: PlanetInfo(
    order: 0,
    name: "Sun",
    color: const Color(0xffBA5C18),
    description: "The Sun is a hot ball of glowing gases at the heart of our solar system. It is the largest object in our solar system and makes up over 99% of its mass. The Sun is so hot that it produces its own light and heat, which powers everything on Earth.",
  ),
  //----------------------------------------------------------------------------
  properties: PlanetProperties(
    gravity: 274,
    distanceFrmEarth: 147,
    distanceFrmSun: 0.0,
    diameter: 1392700,
  ),
  //----------------------------------------------------------------------------
  assets: PLanetAssets(
    planet: (PlanetsAssetsPaths.sunP),
    sound: "",
  ),
  //----------------------------------------------------------------------------
);
