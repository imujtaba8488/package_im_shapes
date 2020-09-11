import 'package:flutter/material.dart';

class Option extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      child: AspectRatio(
        aspectRatio: 1,
        child: CustomPaint(
          size: Size.infinite,
          painter: OptionPainter(),
        ),
      ),
    );
  }
}

class OptionPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.orange
      ..style = PaintingStyle.fill
      ..strokeWidth = 2;

    Offset circleCenter = Offset(size.width / 2.0, size.height / 4.0);
    double circleRadius = size.width / 4.5;

    Offset boxCenter = Offset(size.width / 2.0, size.height / 2.1);

    canvas.drawCircle(
      circleCenter,
      circleRadius,
      paint,
    );

    double space = circleRadius / 20;
    double side = circleRadius / 3;

    Path path = Path()
      ..moveTo(boxCenter.dx - side, boxCenter.dy + space)
      ..lineTo(boxCenter.dx + side, boxCenter.dy + space)
      ..lineTo(boxCenter.dx, boxCenter.dy + side)
      ..lineTo(boxCenter.dx - side, boxCenter.dy + space);

    canvas.drawPath(path, paint);

    Paint paint2 = Paint()
      ..color = Colors.grey
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    Path path2 = Path()
      ..moveTo(boxCenter.dx, boxCenter.dy + side)
      ..lineTo(boxCenter.dx, size.height);

    canvas.drawPath(path2, paint2);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
