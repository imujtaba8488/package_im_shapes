import 'package:flutter/material.dart';

import 'package:im_shapes/im_shapes.dart';
import 'package:im_shapes/src/icon_balloon.dart';

class Inflater extends StatefulWidget {
  final double radius;

  Inflater({this.radius = 200.0});

  @override
  _InflaterState createState() => _InflaterState();
}

class _InflaterState extends State<Inflater>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation animation;

  bool inflated = false;

  @override
  void initState() {
    controller = AnimationController(
      duration: Duration(milliseconds: 500),
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
    double width = widget.radius;
    double height = widget.radius * 1.5;

    animation = Tween(begin: height, end: 0.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: !inflated ? Curves.bounceIn : Curves.bounceOut,
      ),
    );

    return Container(
      width: width,
      height: height,
      child: Stack(
        children: [
          // Positioned(

          //   height: 100,
          //   width: 100,
          //   top: animation.value,
          //   child: Balloon2(
          //   ),
          // ),
          Positioned(
            top: animation.value,
            child: IconBalloon(
              radius: width,
              icon: Icon(Icons.hd, size: width / 3,),
            ),
          ),

          Positioned(
            top: height / 1.5,
            child: InkWell(
              onTap: () {
                setState(() {
                  if (inflated) {
                    controller.reverse();
                  } else {
                    controller.reset();
                    controller.forward();
                  }

                  inflated = !inflated;

                  print('inflated? $inflated');
                });
              },
              child: Container(
                width: width,
                height: height - (height / 1.5),
                alignment: Alignment.center,
                padding: EdgeInsets.all(5.0),
                decoration: BoxDecoration(color: Colors.grey),
                child: inflated ? Text('deflate') : Text('Inflate'),
              ),
            ),
          )
        ],
      ),
    );
  }
}
