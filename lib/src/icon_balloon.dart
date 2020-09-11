import 'package:flutter/material.dart';

import 'balloon2.dart';

class IconBalloon extends StatelessWidget {
  final double radius;
  final Icon icon;

  IconBalloon({this.radius = 60.0, this.icon}) {
    if (icon != null) {
      assert(icon.size <= radius / 2.5, 'Icon size cannot exceed radius / 2.5');
    }
  }

  @override
  Widget build(BuildContext context) {
    double iconSize = icon?.size ?? 24.0;
    return Stack(
      children: [
        Container(
          height: radius,
          width: radius,
          child: Balloon2(),
        ),
        Positioned(
          top: (radius / 2) - iconSize,
          left: (radius / 2) - (iconSize / 2),
          child: Icon(
            icon?.icon,
            size: iconSize,
            color: icon?.color,
          ),
        ),
      ],
    );
  }
}
