import 'package:flutter/material.dart';
import 'package:planets/classes/planet.dart';
import 'package:planets/helpers/assets_path.dart';

Planet mars = Planet(
  //----------------------------------------------------------------------------
  info: PlanetInfo(
    order: 4,
    name: "Mars",
    color: const Color(0xffD63222),
    description: "Mars is the fourth planet from the Sun and the second smallest planet in our solar system. It has a very thin atmosphere made up of carbon dioxide, nitrogen, and argon. Mars also has a rocky surface and two moons, Phobos and Deimos. It orbits the Sun once every 687 Earth days.",
  ),
  //----------------------------------------------------------------------------
  properties: PlanetProperties(
    gravity: 3.7,
    distanceFrmEarth: 55.65,
    distanceFrmSun: 227.9,
    diameter: 6792,
  ),
  //----------------------------------------------------------------------------
  assets: PLanetAssets(
    planet: (PlanetsAssetsPaths.marsP),
    plntLayer: (PlanetsAssetsPaths.marsL),
    sound: "",
  ),
  //----------------------------------------------------------------------------
);
