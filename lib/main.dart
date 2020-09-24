import 'package:flutter/material.dart';
import 'package:im_shapes/src/drop.dart';
import 'package:im_shapes/src/math_extended/math_extended.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation animation;
  Animation animation2;

  double height = 0.0;

  bool inflated = false;

  @override
  void initState() {
    controller = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    )..addListener(() {
        setState(() {});
      });

    controller.forward();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // animation = TweenSequence(
    //   [
    //     TweenSequenceItem(tween: Tween(begin: 0.0, end: 20.0), weight: 1),
    //     TweenSequenceItem(tween: Tween(begin: 20.0, end: 0.0), weight: 1),
    //   ],
    // ).animate(CurvedAnimation(
    //   curve: Curves.ease,
    //   parent: controller,
    // ));

    // height = animation.isCompleted ? 100.0 : 130;

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Icon Stepper Example'),
        ),
        body: Column(
          children: [
            Text('Degrees to Radians:  ${toRadians(60)}'),
            Text('Radians to Degrees: ${toDegrees(toRadians(60))}'),
            Text('Radius: ${CircleMaths.radiusFromCircumference(20)}'),
            Text(
                'Circumference: ${CircleMaths.circumference(CircleMaths.radiusFromCircumference(20))}')
          ],
        ),
      ),
    );
  }

  Widget unknown() {
    return Container(
      height: height,
      width: 100,
      child: Stack(
        children: [
          Positioned(
            top: animation.value,
            child: Container(
              height: 100,
              width: 100,
              child: Drop(),
            ),
          ),
        ],
      ),
    );
  }
}
