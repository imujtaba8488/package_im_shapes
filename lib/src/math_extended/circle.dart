part of 'math_extended.dart';

class CircleMaths {
  static double radiusFromCircumference(double circumference) =>
      circumference / (2 * pi);

  static double circumference(double radius) => 2 * pi * radius;

  static double diameter(double radius) => radius * radius;

  static double radius(double diameter) => diameter / 2;

  static double area(double radius) => pi * radius * radius;

  /// Returns a list of coordinates representing the coordinates of sectors, when a circle is divided into [numberOfSectors] sectors.
  ///
  /// [numberOfSectors]: The number of sectors into which to divide the circle.
  /// [radius]: The radius of the circle.\
  /// [center]: The location of the center of the circle.
  static List<Point> getSectorCoordinates({
    @required int numberOfSectors,
    @required double radius,
    @required Offset center,
  }) {
    double angle = 0;
    List<Point<double>> coordinates = List();

    for (int i = 0; i < numberOfSectors; i++) {
      angle = i * (360 / numberOfSectors);

      Point<double> coordinate = Point(
        center.dx + (radius * (cos(toRadians(angle)))),
        center.dx + (radius * (sin(toRadians(angle)))),
      );

      coordinates.add(coordinate);
    }

    return coordinates;
  }
}
