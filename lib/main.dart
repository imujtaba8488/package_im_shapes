import 'package:flutter/material.dart';
import 'package:im_shapes/src/mission_box.dart';
import 'package:im_shapes/src/ball_on_funnel.dart';

import 'im_shapes.dart';

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

  bool inflated = false;

  @override
  void initState() {
    controller = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    )..addListener(() {
        setState(() {});
      });

    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Icon Stepper Example'),
        ),
        // body: Inflater(),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: BallOnFunnel(),
                  ),
                  Expanded(
                    child: BallOnFunnel(),
                  ),
                  Expanded(
                    child: BallOnFunnel(),
                  ),
                  Expanded(
                    child: BallOnFunnel(),
                  ),
                  Expanded(
                    child: BallOnFunnel(),
                  ),
                  
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
