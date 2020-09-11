import 'package:flutter/material.dart';

class MissionBox extends StatelessWidget {
  final Color color;
  final Color borderColor;
  final double borderWidth;
  final double pointerHeight;

  MissionBox({
    this.color,
    this.borderColor = Colors.black,
    this.borderWidth = 1.0,
    this.pointerHeight = 25.0,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size.infinite,
      painter: MissionBoxPainter(
        color: color,
        borderColor: borderColor,
        borderWidth: borderWidth,
        pointerHeight: pointerHeight
      ),
    );
  }
}

class MissionBoxPainter extends CustomPainter {
  Paint _paint;
  final double pointerHeight;

  MissionBoxPainter({
    this.pointerHeight = 25.0,
    Color color,
    double borderWidth = 1,
    Color borderColor = Colors.black,
  }) {
    _paint = Paint()
      ..color = color == null ? borderColor : color
      ..style = color == null ? PaintingStyle.stroke : PaintingStyle.fill
      ..strokeWidth = 1;
  }
  @override
  void paint(Canvas canvas, Size size) {
    Path path = Path()
      ..lineTo(size.width, 0.0)
      ..lineTo(size.width, size.height - pointerHeight)
      ..lineTo(size.width / 1.8, size.height - pointerHeight)
      ..lineTo(size.width / 2, size.height - pointerHeight + pointerHeight)
      ..lineTo(size.width / 2.2, size.height - pointerHeight)
      ..lineTo(0.0, size.height - pointerHeight)
      ..lineTo(0.0, 0.0);

    canvas.drawPath(path, _paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
