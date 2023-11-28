import 'package:flutter/material.dart';

class Planet {
  final PlanetInfo info;
  final PlanetProperties properties;
  final PLanetAssets assets;

  Planet({
    required this.info,
    required this.properties,
    required this.assets,
  });
}

// -----------------------------------------------------------------------------

class PlanetInfo {
  //
  final int order;
  final String name;
  final Color color;
  final String description;

  PlanetInfo({
    required this.order,
    required this.name,
    required this.color,
    required this.description,
  });
}

// -----------------------------------------------------------------------------

class PlanetProperties {
  //
  final double gravity;
  final double distanceFrmEarth;
  final double distanceFrmSun;
  final double diameter;

  PlanetProperties({
    required this.gravity,
    required this.distanceFrmEarth,
    required this.distanceFrmSun,
    required this.diameter,
  });
}

// -----------------------------------------------------------------------------

class PLanetAssets {
  final String planet;
  final String? plntLayer;
  final String sound;

  PLanetAssets({
    required this.planet,
    required this.sound,
     this.plntLayer,
  });
}

// -----------------------------------------------------------------------------


