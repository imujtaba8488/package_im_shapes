import 'dart:math';

import 'package:flutter/material.dart';

part 'circle.dart';
part 'percent.dart';

/// A radian is the measure of an angle that, when drawn as a central angle of a circle, intercepts an arc whose length is equal to the length of the radius of the circle.

/// Converts an angle in degrees to radians.
double toRadians(double angleInDegrees) => angleInDegrees * (pi / 180);

/// Converts an angle in radians to degrees.
double toDegrees(double angleInRadiuns) =>
    (angleInRadiuns * (180 / pi)).roundToDouble();

/// Returns the center of any shape with a given height and width.
/// Based on Pythagoras Theorem: (h) square = (b) square + (l) square.
/// TEMP: Write detailed doc later.
/// Co-author: 'ISRA ITRAT RAFIQI' on September, 2019.
double centerOf(double height, double width) {
  double l = height * height;
  double b = width * width;
  double h = l + b;

  return h = sqrt(h) / 2.0;
}

/// Gets the given part [whichPart] of a shape which is divided into [howManyParts].
/// Formula: which part / total parts * length.
/// Co-author: 'ISRA ITRAT RAFIQI' on 20th February, 2020.
double partOf({
  @required double length,
  @required double howManyParts,
  @required double whichPart,
}) =>
    whichPart / howManyParts * length;
