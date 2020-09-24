part of 'im_util.dart';

class Circle {
  /// The radius of the circle.
  double radius;

  /// The location of the center of the circle in X, Y plane.
  Offset center;

  Circle({@required this.radius, @required this.center});

  /// Returns the circumference of a circle.
  double get circumference => 2 * pi * radius;

  /// Returns the diameter of the circle.
  double get diameter => radius * radius;

  /// Returns the area of a circle.
  double get area => pi * radius * radius;

  /// Returns a list of coordinates representing the coordinates of sectors, when a circle is divided into [numberOfSectors] sectors.
  ///
  /// [numberOfSectors]: The number of sectors into which to divide the circle.
  List<Point> sectorCoordinates({@required int numberOfSectors}) {
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

  /// Returns the radius of the circle with the given circumference.
  static double radiusFromCircumference(double circumference) =>
      circumference / (2 * pi);
}
