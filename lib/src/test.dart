import 'package:flutter/material.dart';

class Test extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      child: CustomPaint(
        painter: MyPainter(),
        size: Size.infinite,
      ),
    );
  }
}

class MyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    Path path = Path();

    // Path number 1

    paint.color = Color(0xfff20303);
    path = Path();
    path.moveTo(0.0, 0.0);
    path.cubicTo(
      size.width * 0.7,
      size.height,
      -0.43,
      0,
      size.width * 0.7,
      0,
    );
    path.cubicTo(
      size.width * 1.82,
      0,
      size.width * 0.7,
      size.height,
      size.width * 0.7,
      size.height,
    );
    path.cubicTo(size.width * 0.7, size.height, size.width * 0.7, size.height,
        size.width * 0.7, size.height);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
