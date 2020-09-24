import 'package:flutter/material.dart';

class Drop extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RotatedBox(
      quarterTurns: 2,
      child: Align(
        child: AspectRatio(
          aspectRatio: 1,
          child: CustomPaint(
            painter: DropPainter(),
            size: Size.infinite,
          ),
        ),
      ),
    );
  }
}

class DropPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint brush = Paint()
      ..style = PaintingStyle.fill
      ..strokeWidth = 2
      ..color = Colors.blue;

    Offset center = Offset(size.width / 2, size.height / 2.9);

    canvas.drawCircle(
      center,
      size.width / 3,
      brush,
    );

    Path path = Path()
      ..moveTo(size.width / 6.0, size.height / 2.9)
      ..quadraticBezierTo(
        size.width / 6,
        size.height / 1.7,
        size.width / 2,
        size.height / 1.02,
      )
      ..quadraticBezierTo(
        size.width / 1.2,
        size.height / 1.7,
        size.width / 1.2,
        size.height / 3,
      );

    canvas.drawPath(path, brush);
  }

  @override
  bool shouldRepaint(DropPainter oldDelegate) => false;
}
