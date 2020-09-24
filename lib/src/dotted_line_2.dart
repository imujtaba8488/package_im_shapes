import 'package:flutter/material.dart';

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

    canvas.translate(radius, radius);

    double diameter = radius + radius + space;

    int numberOfDots = (size.width / diameter).round();

    print('width: ${size.width}');
    print(numberOfDots);

    for (int i = 0; i < numberOfDots; i++) {
      canvas.drawCircle(
        Offset(diameter * i, 0.0),
        radius,
        Paint()..color = color,
      );
    }
  }

  @override
  bool shouldRepaint(DottedLine2Painter oldDelegate) => false;
}
