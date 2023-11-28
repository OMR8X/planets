import 'package:flutter/material.dart';
import 'package:planets/classes/planet.dart';
import 'package:planets/helpers/assets_path.dart';

Planet earth = Planet(
  //----------------------------------------------------------------------------
  info: PlanetInfo(
    order: 3,
    name: "Earth",
    color: const Color(0xff41AB3B),
    description: "Earth is the third planet from the Sun and the only planet in our solar system known to support life. It has a thin atmosphere made up of nitrogen, oxygen, and other gases. Earth also has a rocky surface and liquid water on its surface. It orbits the Sun once every 365.24 Earth days.",
  ),
  //----------------------------------------------------------------------------
  properties: PlanetProperties(
    gravity: 9.8,
    distanceFrmEarth: 0.0,
    distanceFrmSun: 149.6,
    diameter: 12756,
  ),
  //----------------------------------------------------------------------------
  assets: PLanetAssets(
    planet: (PlanetsAssetsPaths.earthP),
    plntLayer: (PlanetsAssetsPaths.earthL),
    sound: "",
  ),
  //----------------------------------------------------------------------------
);
