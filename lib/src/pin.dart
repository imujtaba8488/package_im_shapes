import 'package:flutter/material.dart';

/// A widget which displays its child within a pin shape.
///
/// __Note:__ It is the sole responsibility of the class user to appropriately size the child placed within the Pin, as the size of the child does not automatically resize the Pin, as it is controlled by its [radius] property
class Pin extends StatelessWidget {
  /// The child to be placed within the pin.
  final Widget child;

  /// The color of the pin shape.
  final Color color;

  /// The color of the area holding the child.
  final Color contentAreaColor;

  /// Determines how big the pin should be.
  final double radius;

  Pin({
    this.radius = 48.0,
    this.color = Colors.blue,
    this.contentAreaColor = Colors.white,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _PinPainter(
        extraHeight: radius,
        color: color,
        contentAreaColor: contentAreaColor,
      ),
      child: Container(
        /// Width and hieght must be given in order to prevent the shape from overflowing.
        width: radius,
        height: radius,

        // Note: If the bottom margin is not set to extra height (radius in this case), the balloon lower belly and string will not appear.
        margin: EdgeInsets.only(bottom: radius / 2.0),
        child: child,
      ),
    );
  }
}

/// The painter which paints the Pin shape.
///
/// The Pin shape consists of 2 parts: the head and the leg. The idea is to draw a circle along the top which makes up for the pin head and use beziers to draw the leg.
class _PinPainter extends CustomPainter {
  /// The color of the shape.
  final Color color;

  /// The color of the area holding the child.
  final Color contentAreaColor;

  /// The height in addition to the height of the child, which is used to accomodate the Pin Leg.
  final double extraHeight;

  _PinPainter({
    this.color = Colors.blue,
    this.contentAreaColor = Colors.white,
    @required this.extraHeight,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // The radius of the Pin Head.
    double radius = size.width / 2.0;

    // Calculate the Pin Head center by subtracting the extraHeight from the total height (height of the child plus the extraHeight) and then divide it by 2.
    Offset center = Offset(size.width / 2.0, size.height - extraHeight);

    // Remember: draw order is important.
    _drawLeg(canvas, size, radius, color);
    _drawHead(canvas, center, radius, color);
    _drawHead(canvas, center, radius * 0.7, contentAreaColor);
  }

  /// Draws the Pin Leg.
  void _drawLeg(Canvas canvas, Size size, double radius, Color color) {
    // Where the left bezier begins along x-axis.
    double xStart = size.width / 7.0;

    // Where the right bezier ends along x-axis.
    double xEnd = size.width - xStart;

    // Where the left and right beziers meet/intersect along x-axis.
    double xIntersect = size.width / 2.0;

    // Where the left bezier begins along y-axis.
    double yStart = size.height / 1.8;

    // Where the left and right bezier meet/intersect along y-axis.
    double yIntersect = size.height;

    // Control point of bezier along x-axis
    double controlPointX = size.width / 3.0;

    // Control point of left bezier along y-axis
    double controlPointY = size.height / 1.5;

    Path path = Path()
      ..moveTo(xStart, yStart)
      ..quadraticBezierTo(
        controlPointX,
        controlPointY,
        xIntersect,
        yIntersect,
      )
      ..quadraticBezierTo(
        size.width - controlPointX,
        controlPointY,
        xEnd,
        yStart,
      );

    canvas.drawPath(
      path,
      Paint()
        ..color = color
        ..style = PaintingStyle.fill,
    );
  }

  /// Draws the Pin Head. Also used to draw the child content area.
  void _drawHead(Canvas canvas, Offset center, double radius, Color color) {
    canvas.drawCircle(
      center,
      radius,
      Paint()
        ..color = color
        ..style = PaintingStyle.fill,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
