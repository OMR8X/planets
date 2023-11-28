import 'package:flutter/material.dart';
import 'package:planets/classes/planet.dart';
import 'package:planets/helpers/assets_path.dart';

Planet venus = Planet(
  //----------------------------------------------------------------------------
  info: PlanetInfo(
    order: 2,
    name: "Venus",
        color: const Color(0xff335752),
    description: "Venus is the second planet from the Sun and the hottest planet in our solar system. It has a very thick atmosphere made up of carbon dioxide and sulfuric acid. Venus also has a rocky surface, but it is covered in volcanoes and mountains. It orbits the Sun once every 225 Earth days.",
  ),
  //----------------------------------------------------------------------------
  properties: PlanetProperties(
    gravity: 8.9,
    distanceFrmEarth: 39.79,
    distanceFrmSun: 108.2,
    diameter: 12104,
  ),
  //----------------------------------------------------------------------------
  assets: PLanetAssets(
    planet: (PlanetsAssetsPaths.venusP),
    sound: "",
  ),
  //----------------------------------------------------------------------------
);
