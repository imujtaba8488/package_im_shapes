import 'dart:math' as math;

import 'package:flutter/material.dart';

typedef _Coordinates = void Function(List<double> x, List<double> y);

class ShapesFromCircle extends StatelessWidget {
  final Paint brush;
  final int numberOfSectors;
  final bool showGuides;

  ShapesFromCircle({
    this.brush,
    this.numberOfSectors = 3,
    this.showGuides = false,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: AspectRatio(
        aspectRatio: 1,
        child: CustomPaint(
          size: Size.infinite,
          painter: _ShapePainter(
            brush: brush,
            numberOfSectors: numberOfSectors,
            showGuides: showGuides,
          ),
        ),
      ),
    );
  }
}

/// The painter which paints the shapes within a circle by dividing the circle into sectors etc.
class _ShapePainter extends CustomPainter {
  Paint brush;
  final int numberOfSectors;
  final bool showGuides;
  final Connections connections;

  _ShapePainter({
    this.brush,
    this.numberOfSectors = 3,
    this.showGuides = false,
    this.connections = Connections._drawLinesALongCircumference,
  }) {
    brush ??= Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
  }

  @override
  void paint(Canvas canvas, Size size) {
    switch (connections) {
      case Connections._drawLinesFromCenter:
        _joinPointsFromCenter(canvas, size);
        break;

      default:
        _joinPointsAlongCircumference(canvas, size);
        break;
    }

    if (showGuides) {
      _drawCircleGuide(canvas, size);
      _drawCenterPointGuide(canvas, size);
      _drawBisectingLinesGuide(canvas, size);
    }
  }

  /// Draws lines by connecting the sector coordinates along the circumference.
  void _joinPointsAlongCircumference(Canvas canvas, Size size) {
    Path path = Path();

    sectorPointCoordinates(
      numberOfSectors: numberOfSectors,
      center: size.center(Offset(0.0, 0.0)),
      radius: size.width / 2,
      coordinates: (xCoordinate, yCoordinate) {
        // Move to the initial coordinate.
        path.moveTo(xCoordinate[0], yCoordinate[0]);

        // Connect coordinates by drawing lines along the circumference.
        for (int i = 0; i < numberOfSectors; i++) {
          path..lineTo(xCoordinate[i], yCoordinate[i]);
        }

        // Close path draws the last line by connecting the last coordinate with the initial coordinate.
        path.close();
      },
    );

    canvas.drawPath(path, brush);
  }

  /// Draws lines from center to sector coordinates. ![test](https://github.com/imujtaba8488/showcase/blob/master/im_stepper/image_stepper_02.gif)
  void _joinPointsFromCenter(Canvas canvas, Size size) {
    Path path = Path();

    sectorPointCoordinates(
      numberOfSectors: numberOfSectors,
      center: size.center(Offset(0.0, 0.0)),
      radius: size.width / 2,
      coordinates: (xCoordinate, yCoordinate) {
        Offset center = size.center(Offset(0.0, 0.0));

        // Draw lines from center radiating towards the sector coordinates.
        for (int i = 0; i < numberOfSectors; i++) {
          canvas.drawLine(
            Offset(center.dx, center.dy),
            Offset(xCoordinate[i], yCoordinate[i]),
            brush,
          );
        }
      },
    );

    canvas.drawPath(path, brush);
  }

  /// Draws the circle guide.
  void _drawCircleGuide(Canvas canvas, Size size) {
    canvas.drawCircle(
      size.center(Offset(0.0, 0.0)),
      size.width / 2,
      Paint()
        ..color = Colors.grey
        ..style = PaintingStyle.stroke,
    );
  }

  /// Draws the center point guide.
  void _drawCenterPointGuide(Canvas canvas, Size size) {
    canvas.drawCircle(
      size.center(Offset(0.0, 0.0)),
      3.0,
      brush
        ..color = Colors.grey
        ..style = PaintingStyle.fill,
    );
  }

  /// Draws the horizontal and vertical bisecting line guides.
  void _drawBisectingLinesGuide(Canvas canvas, Size size) {
    // Draw horizontal bisecting line guide.
    canvas.drawLine(
      Offset(0.0, size.height / 2.0),
      Offset(size.width, size.height / 2),
      brush
        ..color = Colors.grey
        ..strokeWidth = 0.5,
    );

    // Draw vertical bisecting line guide.
    canvas.drawLine(
      Offset(size.width / 2, 0.0),
      Offset(size.width / 2, size.height),
      brush
        ..color = Colors.grey
        ..strokeWidth = 0.5,
    );
  }

  /// Provides the coordinates of points, when a circle is divided into equal sectors.
  ///
  /// Function idea: @__ISRA ITRAT RAFIQI__.
  ///
  /// [numberOfSectors] The number of sectors into which to divide the circle.
  ///
  /// [center] The center coordinates of the circle.
  ///
  /// [radius] The radius of the circle.
  ///
  /// [coordinates] The function which provides the point coordinates.
  void sectorPointCoordinates({
    int numberOfSectors = 3,
    @required Offset center,
    @required double radius,
    _Coordinates coordinates,
  }) {
    assert(
      numberOfSectors >= 3,
      'numberOfSectors must be greater than or equal to 3',
    );

    double degrees = 0;

    // x-coordinates
    List<double> x = List(numberOfSectors);

    // y-coordinates
    List<double> y = List(numberOfSectors);

    for (int i = 0; i < numberOfSectors; i++) {
      degrees = i * (360 / numberOfSectors);

      x[i] = center.dx + radius * math.cos(toRadians(degrees));
      y[i] = center.dy + radius * math.sin(toRadians(degrees));
    }

    coordinates(x, y);
  }

  /// Converts the [angle] in degrees to radians.
  double toRadians(double angle) => angle * math.pi / 180;

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

enum Connections {
  _drawLinesALongCircumference,
  _drawLinesFromCenter,
}
