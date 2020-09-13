import 'package:flutter/material.dart';

/// A basic shape representing a ball on a funnel. Typically, the ball may contain an Icon or an Image, while as, the funnel may point to some other widget.
/// 
/// __Note:__ When placed inside a `Row` or a `Column` with unconstrained size, ensure to wrap the shape within an `Expanded` widget.
class BallOnFunnel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    /// It is important to wrap AspectRatio within Align (as per the official doc) to avoid error such as when wrapped within expanded, stack, etc.
    return Align(
      child: AspectRatio(
        aspectRatio: 1,
        child: CustomPaint(
          size: Size.infinite,
          painter: BallOnFunnelPainter(),
        ),
      ),
    );
  }
}

/// Painter that paints the Ball on a Funnel.
///
/// The idea here is that the CustomPaint object passes canvas with infinite size wrapped inside a aspect ratio of 1, making it a square. This square is divided into three regions to contain three parts of the ball and funnel, i.e. the ball, funnel neck, and the funnel pipe. First a circle is used to draw the ball, then lines are used to draw the funnel neck, and then finally a straight line represents the funnel pipe, who's width can be customized.
class BallOnFunnelPainter extends CustomPainter {
  /// The paint to apply to the shape.
  Paint _paint;

  BallOnFunnelPainter({
    Color color = Colors.purple,
    double funnelPipeWidth = 1.0,
  }) {
    assert(funnelPipeWidth > 0.0, 'strokeWith must be greater than 0.0.');

    _paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill
      ..strokeWidth = funnelPipeWidth;
  }

  @override
  void paint(Canvas canvas, Size size) {
    // Where the center of the ball (circle) is located.
    Offset ballCenter = Offset(size.width / 2.0, size.height / 3.0);

    // The radius of the ball (circle).
    double ballRadius = size.width / 3.0;

    // Where the center of the canvas is located.
    Offset canvasCenter = Offset(size.width / 2.0, size.height / 2.1);

    // The downward or upward distance from the the canvas center.
    double spaceY = ballRadius / 1.5;

    // The size of a side of the funnel neck.
    double neckSide = ballRadius / 2;

    // The draw order is important. Funnel stick is drawn first to match it with the funnel neck, in case the width of the stick is increased.
    _drawBall(canvas, ballCenter, ballRadius);
    _drawFunnelPipe(canvas, canvasCenter, neckSide, spaceY);
    _drawFunnelNeck(canvas, canvasCenter, neckSide, spaceY);
  }

  /// Draws the ball with the given radius and at the given center.
  void _drawBall(Canvas canvas, Offset ballCenter, double ballRadius) {
    canvas.drawCircle(
      ballCenter,
      ballRadius,
      _paint,
    );
  }

  /// Draws the funnel neck.
  void _drawFunnelNeck(
    Canvas canvas,
    Offset boxCenter,
    double side,
    double spaceY,
  ) {
    Path path = Path()
      ..moveTo(boxCenter.dx - side, boxCenter.dy + spaceY)
      ..lineTo(boxCenter.dx + side, boxCenter.dy + spaceY)
      ..lineTo(boxCenter.dx, boxCenter.dy + side + spaceY)
      ..lineTo(boxCenter.dx - side, boxCenter.dy + spaceY);

    canvas.drawPath(
      path,
      _paint..style = PaintingStyle.fill,
    );
  }

  /// Draws the funnel pipe.
  void _drawFunnelPipe(
    Canvas canvas,
    Offset boxCenter,
    double side,
    double spaceY,
  ) {
    Path path2 = Path()
      ..moveTo(boxCenter.dx, boxCenter.dy + spaceY)
      ..lineTo(boxCenter.dx, boxCenter.dy * 2);

    canvas.drawPath(
      path2,
      _paint
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
