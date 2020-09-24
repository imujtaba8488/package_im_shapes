import 'dart:math';

import 'package:flutter/material.dart';

part 'circle.dart';

/// A radian is the measure of an angle that, when drawn as a central angle of a circle, intercepts an arc whose length is equal to the length of the radius of the circle.

/// Converts an angle in degrees to radians.
double toRadians(double angleInDegrees) => angleInDegrees * (pi / 180);

/// Converts an angle in radians to degrees.
double toDegrees(double angleInRadiuns) =>
    (angleInRadiuns * (180 / pi)).roundToDouble();
