import 'package:flutter/material.dart';

/// A balloon widget that can be used in a variety of situations. For example, it can be used to display images, icons using a Stack widget, by placing the balloon widget at the bottom of the stack. 
/// 
/// __Note: Keep in mind that using it in certain places might require it to assign size constraints. For example, when placing inside a `Row` or a `Column`, if not assigned exact dimensions i.e. height and width by wrapping inside a `Container`, etc, ensure to put it inside an `Expanded` widget.__
class Balloon2 extends StatelessWidget {
  /// The color of the belly and neck of the balloon.
  final Color bodyColor;

  /// The color of the string attached to the balloon.
  final Color stringColor;

  Balloon2({this.bodyColor = Colors.red, this.stringColor = Colors.red});

  @override
  Widget build(BuildContext context) {
    /// It is important to wrap AspectRatio within Align (as per the official doc) to avoid error such as when wrapped within expanded, stack, etc.
    return Align(
      child: AspectRatio(
        aspectRatio: 1,
        child: CustomPaint(
          size: Size.infinite,
          painter: _Balloon2Painter(
            bodyColor: bodyColor,
            stringColor: stringColor,
          ),
        ),
      ),
    );
  }
}

/// Painter that paints the balloon.
///
/// The idea here is that the CustomPaint object passes canvas with infinite size wrapped inside a aspect ratio of 1, making it a square. This square is divided into four regions to contain four parts of the balloon, i.e. the upper belly, lower belly, the neck, and the string. First a circle is used to draw the upper belly of the balloon, then beziers are used to draw the lower belly, then lines are used to draw the neck and finally again a bezier is used to draw the balloon string.
class _Balloon2Painter extends CustomPainter {
  /// The paint for the belly and the neck.
  Paint _bodyPaint;

  /// The paint for the string attached to the balloon.
  Paint _stringPaint;

  _Balloon2Painter({
    Color bodyColor = Colors.red,
    Color stringColor = Colors.red,
  }) {
    _bodyPaint = Paint()
      ..color = bodyColor
      ..style = PaintingStyle.fill
      ..strokeWidth = 2.0;

    _stringPaint = Paint()
      ..color = stringColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;
  }

  @override
  void paint(Canvas canvas, Size size) {
    // Center pushed up along y-axis to leave room for the lower belly, neck and string of the balloon, hence, 'size.height / 3.0'.
    Offset center = Offset(size.width / 2.0, size.height / 3.0);

    // Radius chosen as such to fit inside the size passed by the CustomPaint.
    double radius = size.width / 3.1;

    // Draw upper belly.
    canvas.drawCircle(
      center,
      radius,
      _bodyPaint,
    );

    // Draw lower belly.
    Path path = Path()
      ..moveTo((size.width / 2 - radius), center.dy)
      // ..lineTo(size.width / 2, size.height * 0.8);
      ..quadraticBezierTo(
        radius / 1.8,
        size.height / 1.8,
        size.width / 2,
        size.height * 0.8,
      )
      ..quadraticBezierTo(
        size.width - (radius / 1.8),
        size.height / 1.8,
        radius * 2.55,
        size.height / 3.0,
      );

    canvas.drawPath(path, _bodyPaint);

    // Draw neck.
    Path path2 = Path()
      ..moveTo(size.width / 2.0, size.height * 0.8)
      ..lineTo(size.width / 2.1, size.height * 0.82)
      ..moveTo(size.width / 2.0, size.height * 0.8)
      ..lineTo(size.width / 1.92, size.height * 0.82)
      ..lineTo(size.width / 2.1, size.height * 0.82);

    canvas.drawPath(path2, _bodyPaint);

    // Draw string
    Path path3 = Path()
      ..moveTo(size.width / 2.0, size.height * 0.82)
      ..quadraticBezierTo(
        size.width / 2.2,
        size.height * 0.85,
        size.width / 2.0,
        size.height * 0.9,
      );

    canvas.drawPath(path3, _stringPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
