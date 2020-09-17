import 'package:flutter/material.dart';

import 'dart:math' as math;

class CircleWorld extends StatelessWidget {
  final int numberOfSectors;

  CircleWorld({this.numberOfSectors = 3});

  @override
  Widget build(BuildContext context) {
    return Align(
      child: AspectRatio(
        aspectRatio: 1,
        child: Stack(
          children: [
            CustomPaint(
              painter: CircleWorldPainter(
                numberOfSectors: numberOfSectors,
              ),
              size: Size.infinite,
            ),
          ],
        ),
      ),
    );
  }
}

class CircleWorldPainter extends CustomPainter {
  int numberOfSectors;
  Paint brush;

  CircleWorldPainter({this.numberOfSectors = 3}) {
    brush = Paint()
      ..style = PaintingStyle.stroke
      ..color = Colors.blueGrey[700];
  }

  @override
  void paint(Canvas canvas, Size size) {
    Offset center = size.center(Offset(0.0, 0.0));
    double radius = size.width / 2.0;

    // drawGuideCircle(canvas, size);

    List<Coordinate> coordinates = getSectorCoordinates(
      numberOfSectors: numberOfSectors,
      center: center,
      radius: radius / 1.5,
    );

    List<Coordinate> coordinates2 = getSectorCoordinates(
      numberOfSectors: numberOfSectors,
      center: center,
      radius: radius,
    );

    Path path2 = Path()
      ..moveTo(
        coordinates2[numberOfSectors - 1].x,
        coordinates2[numberOfSectors - 1].y,
      );

    for (int i = 0; i < coordinates2.length; i++) {
      // drawGuidePoints(canvas, coordinates[i]);

      path2..lineTo(coordinates2[i].x, coordinates2[i].y);
    }

    canvas.drawPath(
      path2,
      Paint()..color = Colors.blueGrey[400],
    );

    Path path = Path()
      ..moveTo(
        coordinates[numberOfSectors - 1].x,
        coordinates[numberOfSectors - 1].y,
      );

    for (int i = 0; i < coordinates.length; i++) {
      // drawGuidePoints(canvas, coordinates[i]);

      path..lineTo(coordinates[i].x, coordinates[i].y);
    }

    canvas.drawPath(path, brush..style = PaintingStyle.fill);
  }

  void drawGuidePoints(Canvas canvas, Coordinate coordinate) {
    canvas.drawCircle(
      Offset(coordinate.x, coordinate.y),
      3,
      Paint()..color = Colors.grey,
    );
  }

  void drawGuideCircle(Canvas canvas, Size size) {
    canvas.drawCircle(
      size.center(Offset(0.0, 0.0)),
      size.width / 2.0,
      Paint()
        ..color = Colors.grey
        ..style = PaintingStyle.stroke,
    );
  }

  @override
  bool shouldRepaint(CircleWorldPainter oldDelegate) => false;

  List<Coordinate> getSectorCoordinates({
    @required int numberOfSectors,
    @required double radius,
    @required Offset center,
  }) {
    double angle = 0;
    List<Coordinate> coordinates = List();

    for (int i = 0; i < numberOfSectors; i++) {
      angle = i * (360 / numberOfSectors);

      Coordinate coordinate = Coordinate();

      coordinate.x = center.dx + (radius * (math.cos(toRadians(angle))));
      coordinate.y = center.dx + (radius * (math.sin(toRadians(angle))));

      coordinates.add(coordinate);
    }

    return coordinates;
  }

  double toRadians(double angleInDegress) => angleInDegress * math.pi / 180;
}

class Coordinate {
  double x;
  double y;
}
