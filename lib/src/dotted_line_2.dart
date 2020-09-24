import 'package:flutter/material.dart';
import 'package:im_shapes/src/custom_painter_util/im_util.dart';

class DottedLine2 extends StatelessWidget {
  final double radius;
  final double space;
  final Color color;

  DottedLine2({this.radius = 3, this.space = 3, this.color = Colors.grey});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: DottedLine2Painter(
        radius: radius,
        space: space,
      ),
      size: Size.infinite,
    );
  }
}

class DottedLine2Painter extends CustomPainter {
  double radius;
  double space;
  Color color;

  DottedLine2Painter({
    this.radius = 3.0,
    this.space = 2,
    this.color = Colors.grey,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // Translate so that the circle doesn't go off the screen.
    canvas.translate(radius, radius);

    Circle circle = Circle(
      radius: radius,
      center: size.center(Offset(0.0, 0.0)),
    );

    int numberOfDots = (size.width / (circle.diameter + space)).round();

    for (int i = 0; i < numberOfDots; i++) {
      canvas.drawCircle(
        Offset((circle.diameter + space) * i, 0.0),
        circle.radius,
        Paint()..color = color,
      );
    }
  }

  @override
  bool shouldRepaint(DottedLine2Painter oldDelegate) => false;
}
