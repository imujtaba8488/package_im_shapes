import 'package:flutter/material.dart';

/// A widget which displays its child within a balloon shape.
///
/// __Note:__ It is the sole responsibility of the class user to appropriately size the child placed within the balloon, as the size of the child does not automatically resize the balloon, as it is controlled by its [radius] property.
class Balloon extends StatelessWidget {
  /// Determines how big a balloon should be.
  final double radius;

  /// The color of the balloon and it's string.
  final Color color;

  /// The child to be placed within the balloon.
  ///
  /// __Note:__ child must be set to appropriate size by the class user in order to prevent it from overflowing.
  final Widget child;

  Balloon({
    this.radius = 48.0,
    this.color = Colors.blue,
    this.child,
  }) {
    assert(radius > 0.0, 'Radius must be greater than 0.0');
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _BalloonPainter(
        extraHeight: radius,
        color: color,
      ),
      child: Container(
        /// Width and hieght must be given in order to prevent the shape from overflowing.
        width: radius,
        height: radius,
        alignment: Alignment.center,

        // Note: If the bottom margin is not set to extra height (radius in this case), the balloon lower belly and string will not appear.
        margin: EdgeInsets.only(
          bottom: radius,
        ),
        child: child,
      ),
    );
  }
}

/// The painter which paints the balloon shape.
///
/// The balloon consists of two parts: belly and the string. The idea is to first draw a circle which forms the upper belly of the balloon, then use beziers to draw the lower belly of the balloon, and finally draw a vertical line to represent the balloon string.
class _BalloonPainter extends CustomPainter {
  /// The color of the shape.
  final Color color;

  /// The height in addition to the height of the child, which is used to accomodate the balloon lower belly and the string.
  double extraHeight;

  /// The paint brush used to draw the shape.
  Paint _paintBrush;

  _BalloonPainter({
    this.color = Colors.blue,
    @required this.extraHeight,
  }) : _paintBrush = Paint()
          ..style = PaintingStyle.fill
          ..color = color
          ..strokeWidth = 2.0;

  @override
  void paint(Canvas canvas, Size size) {
    // The radius of the upper belly of the balloon.
    double radius = size.width / 2;

    // Calculate the upper belly center by subtracting the extraHeight (space used for lower belly and the string) from the total height (height of the child plus the extraHeight for lower belly and the string) and then divide it by 2.
    Offset upperBellyCenter = Offset(
      size.width / 2.0,
      (size.height - extraHeight) / 2.0,
    );

    // Draw order is important.
    _drawUpperBelly(canvas, upperBellyCenter, radius, color);
    _drawLowerBelly(canvas, size, radius, color);
    _drawString(canvas, size);
  }

  /// Draws the upper bolloon belly.
  void _drawUpperBelly(
    Canvas canvas,
    Offset center,
    double radius,
    Color color,
  ) {
    canvas.drawCircle(
      center,
      radius,
      _paintBrush,
    );
  }

  /// Draws the lower balloon belly.
  void _drawLowerBelly(Canvas canvas, Size size, double radius, Color color) {
    Path path = Path()
      ..moveTo(0.0, (size.height - extraHeight) / 2)
      ..quadraticBezierTo(
        0.0,
        size.height / 2,
        size.width / 2.0,
        size.height / 1.3,
      )
      ..quadraticBezierTo(
        size.width,
        size.height / 2.0,
        size.width,
        (size.height - extraHeight) / 2,
      );

    canvas.drawPath(
      path,
      _paintBrush,
    );
  }

  /// Draws the string attached to the lower belly of the balloon.
  void _drawString(Canvas canvas, Size size) {
    canvas.drawLine(
      Offset(size.width / 2.0, size.height / 1.31),
      Offset(size.width / 2.0, size.height),
      _paintBrush,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
