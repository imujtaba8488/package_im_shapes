import 'dart:math' as math;

import 'package:flutter/material.dart';

typedef _Coordinates = void Function(List<double> x, List<double> y);

/// Todo: Soften the edges.
/// Todo: Arrangments can be combined.
/// A widget that generates shapes by dividing a circle into sectors. The coordinates of these sectors are calculated and then they are joined based on the [arrangement].
class ShapesFromCircle extends StatelessWidget {
  /// The paint brush to be used for the shapes.
  final Paint brush;

  /// Total number of sectors the circle needs to be divided into. Must be greater than or equal to 3.
  final int numberOfSectors;

  /// Whether to show circle, etc guides or not.
  final bool showGuides;

  /// Defines how the coordinates of sectors should be connected.
  final Arrangement arrangement;

  ShapesFromCircle({
    this.brush,
    this.numberOfSectors = 3,
    this.showGuides = false,
    this.arrangement = Arrangement.drawLinesALongCircumference,
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
            arrangement: arrangement,
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
  final Arrangement arrangement;

  _ShapePainter({
    this.brush,
    this.numberOfSectors = 3,
    this.showGuides = false,
    this.arrangement = Arrangement.drawLinesALongCircumference,
  }) {
    brush ??= Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
  }

  @override
  void paint(Canvas canvas, Size size) {
    switch (arrangement) {
      case Arrangement.drawLinesFromCenter:
        _joinPointsFromCenter(canvas, size);
        break;

      case Arrangement.drawLinesFromOrigin:
        _joinPointsFromOrigin(canvas, size);
        break;

      case Arrangement.drawLinesFromTopCenter:
        _jointPointsFromTopCenter(canvas, size);
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
        Path path = Path()..moveTo(xCoordinate[0], yCoordinate[0]);

        for (int i = 1; i < numberOfSectors; i++) {
          path.lineTo(xCoordinate[i], yCoordinate[i]);
        }

        path.close();
        canvas.drawPath(path, brush);
      },
    );

    canvas.drawPath(path, brush);
  }

  /// Draws lines from center to sector coordinates.
  void _joinPointsFromCenter(Canvas canvas, Size size) {
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
  }

  void _joinPointsFromOrigin(Canvas canvas, Size size) {
    sectorPointCoordinates(
      numberOfSectors: numberOfSectors,
      center: size.center(Offset(0.0, 0.0)),
      radius: size.width / 2,
      coordinates: (xCoordinate, yCoordinate) {
        // Draw lines from origin radiating towards the sector coordinates.
        for (int i = 0; i < numberOfSectors; i++) {
          canvas.drawLine(
            Offset(0.0, 0.0),
            Offset(xCoordinate[i], yCoordinate[i]),
            brush,
          );
        }
      },
    );
  }

  void _jointPointsFromTopCenter(Canvas canvas, Size size) {
    sectorPointCoordinates(
      numberOfSectors: numberOfSectors,
      center: size.center(Offset(0.0, 0.0)),
      radius: size.width / 2,
      coordinates: (xCoordinate, yCoordinate) {
        // Draw lines from origin radiating towards the sector coordinates.
        for (int i = 0; i < numberOfSectors; i++) {
          canvas.drawLine(
            Offset(size.width / 2, 0.0),
            Offset(xCoordinate[i], yCoordinate[i]),
            brush,
          );
        }
      },
    );
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
    // assert(
    //   numberOfSectors >= 3,
    //   'numberOfSectors must be greater than or equal to 3',
    // );

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
  bool shouldRepaint(CustomPainter oldDelegate) {
    // od stands for OldDelegate.
    _ShapePainter od = oldDelegate as _ShapePainter;

    return od.brush != brush ||
        od.numberOfSectors != numberOfSectors ||
        od.arrangement != arrangement ||
        od.showGuides != showGuides;
  }
}

/// Determines the manner in which the coordinates of the sectors of the circle should be connected.
enum Arrangement {
  /// Straight lines connect the sector coordinates along the circumference of the cricle.
  drawLinesALongCircumference,

  /// Straight lines connect the sector coordinates from the center of the circle.
  drawLinesFromCenter,

  /// Straight lines connect the sector coordinates from the origin of the canvas.
  drawLinesFromOrigin,

  /// Straight lines connect the sector coordinates from the topCenter of the canvas.
  drawLinesFromTopCenter,
}
