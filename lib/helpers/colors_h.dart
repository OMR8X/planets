import 'package:flutter/material.dart';

class ColorsHelper {
  static const Color grey = Color(0xff0F0F0F);
  static const Color greyDrk = Color(0xff0C0C0C);

  static const Color button = Color(0xff4A4458);
  //
  static const Color meteor1 = Color(0xff171717);
  static const Color meteor2 = Color(0xff363636);

static  particle(double d) {
    const Color particle1 = Color(0xffE03600);
    const Color particle2 = Color(0xffE07900);
    const Color particle3 = Color(0xffE0AF00);
    const Color particle4 = Color(0xff575353);
    if (d > 0.75) {
      return particle1;
    }
    if (d > 0.5) {
      return particle2;
    }
    if (d > 0.25) {
      return particle3;
    }
    return particle4;
  }
}
