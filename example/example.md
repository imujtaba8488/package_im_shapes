# Examples - Table of Contents

- [IconStepper](#iconstepper)

- [DotStepper](#dotstepper)

- [ImageStepper](#imagestepper)

- [NumberStepper](#numberstepper)

## IconStepper

```dart
import 'package:flutter/material.dart';

import 'package:im_stepper/stepper.dart';

void main() {
  runApp(IconStepperDemo());
}

class MyApp extends StatefulWidget {
  @override
  _IconStepperDemo createState() => _IconStepperDemo();
}

class _IconStepperDemo extends State<IconStepperDemo> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Icon Stepper Example'),
        ),
        body: Row(
          children: <Widget>[
            Container(
              // margin: EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                color: Colors.blueGrey,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    spreadRadius: 1.0,
                    blurRadius: 2.0,
                  )
                ],
                // borderRadius: BorderRadius.circular(5.0),
              ),
              child: IconStepper(
                direction: Axis.vertical,
                // enableNextPreviousButtons: false,
                stepColor: Colors.white,
                activeStepColor: Colors.amber,
                lineColor: Colors.amberAccent,
                // lineDotRadius: 2,
                lineLength: 75,
                onStepReached: (value) {
                  setState(() {
                    print('value: $value');
                    selectedIndex = value;
                  });
                },
                steppingEnabled: true,
                icons: [
                  Icon(Icons.home),
                  Icon(Icons.person),
                  Icon(Icons.account_balance),
                  Icon(Icons.access_time),
                  Icon(Icons.dashboard),
                  Icon(Icons.cached),
                  Icon(Icons.unarchive),
                  Icon(Icons.backspace),
                  Icon(Icons.backup),
                  Icon(Icons.battery_unknown),
                  Icon(Icons.cake),
                  Icon(Icons.call),
                  Icon(Icons.call_end),
                  Icon(Icons.block),
                  Icon(Icons.mail),
                  Icon(Icons.face),
                  Icon(Icons.fast_forward),
                  Icon(Icons.gamepad),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(width: 0.1),
              ),
              padding: EdgeInsets.all(8.0),
              alignment: Alignment.centerLeft,
              child: Text(header()),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.all(5.0),
                child: FittedBox(
                  child: Center(
                    child: Text('${selectedIndex + 1}'),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String header() {
    switch (selectedIndex) {
      case 0:
        return 'Educational Background';

      case 1:
        return 'Professional Background';

      case 2:
        return 'Awards';

      case 3:
        return 'Sports';

      case 4:
        return 'Specially abled';

      case 5:
        return 'Personal Details';

      case 6:
        return 'Social Details';

      case 7:
        return 'Review';

      default:
        return 'Unknown';
    }
  }
}
```

## DotStepper

```Dart
import 'package:flutter/material.dart';

import 'package:im_stepper/stepper.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool stepNext = false;
  bool stepPrevious = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Icon Stepper Example'),
        ),
        body: SafeArea(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        // ***DON'T FORGET***
                        stepNext = false;
                        stepPrevious = true;
                      });
                    },
                    icon: Icon(Icons.chevron_left),
                  ),
                  DotStepper(
                    goNext: stepNext,
                    goPrevious: stepPrevious,
                    dotCount: 5,
                    indicatorEffect: IndicatorEffect.jump,
                    // indicatorType: IndicatorType.contain,
                    // direction: Axis.vertical,
                    // dotRadius: 150,
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        // ***DON'T FORGET***
                        stepPrevious = false;
                        stepNext = true;
                      });
                    },
                    icon: Icon(Icons.chevron_right),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
```

## ImageStepper

```Dart
import 'package:flutter/material.dart';


import 'package:im_stepper/stepper.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Icon Stepper Example'),
        ),
        body: ImageStepper(
          // direction: Axis.vertical,
          // stepRadius: 48.0,
          activeStepBorderPadding: 20.0,
          images: [
            AssetImage('assets/me.jpg'),
            AssetImage('assets/me.jpg'),
            AssetImage('assets/me.jpg'),
            AssetImage('assets/me.jpg'),
            AssetImage('assets/me.jpg'),
            AssetImage('assets/me.jpg'),
            AssetImage('assets/me.jpg'),
          ],
        ),
      ),
    );
  }
}
```

## NumberStepper

```dart
import 'package:flutter/material.dart';

import 'package:im_stepper/stepper.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Icon Stepper Example'),
        ),
        body: NumberStepper(
          // stepRadius: 48.0,
          numbers: [1, 2, 3, 4, 5, 6],
          direction: Axis.vertical,
          numberStyle: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
```
