import 'dart:math';

import 'package:flutter/material.dart';

import 'custom_painter_util/im_util.dart';

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
  Circle circle;

  CircleWorldPainter({this.numberOfSectors = 3}) {
    brush = Paint()
      ..style = PaintingStyle.stroke
      ..color = Colors.blueGrey[700];
  }

  @override
  void paint(Canvas canvas, Size size) {
    circle = Circle(
      radius: size.width / 2,
      center: size.center(Offset(0.0, 0.0)),
    );

    drawGuideCircle(canvas, circle);

    List<Point> coordinates =
        circle.sectorCoordinates(numberOfSectors: numberOfSectors);

    List<Point> coordinates2 =
        circle.sectorCoordinates(numberOfSectors: numberOfSectors);

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

  void drawGuidePoints(Canvas canvas, Point coordinate) {
    canvas.drawCircle(
      Offset(coordinate.x, coordinate.y),
      3,
      Paint()..color = Colors.grey,
    );
  }

  void drawGuideCircle(Canvas canvas, Circle circle) {
    canvas.drawCircle(
      circle.center,
      circle.radius,
      Paint()
        ..color = Colors.grey
        ..style = PaintingStyle.stroke,
    );
  }

  @override
  bool shouldRepaint(CircleWorldPainter oldDelegate) => false;
}
