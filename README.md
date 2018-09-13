# holding_gesture

A customized GestureDetector that acts on holding a determined Widget.

## Getting Started

```dart
import 'package:holding_gesture/holding_gesture.dart';
```

After importing, all you have to do is use `HoldDetector` the same way you already used `GestureDetector`! As it is on the documentation, its `onTap` override won't work when using a child that has `onPressed` or a similar callback, so you should pass the single tap behaviour to that.

```dart
@override
Widget build(BuildContext context) {
  return MaterialApp(
    home: Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed (or held) the button this many times:',
            ),
            Text(
                '$_counter',
                style: Theme.of(context).textTheme.display1,
              ),
          ],
        ),
      ),
      floatingActionButton: HoldDetector(
        onHold: _incrementCounter,
        holdTimeout: Duration(milliseconds: 200),
        enableHapticFeedback: true,
        child: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: _incrementCounter,
      ),
    ),
  ),
);
```

The main example, above and in `example/`, is the same as the default Flutter app, with the adition of a haptic feedback to each tick and the ability to hold the button to keep adding to the counter.

For help getting started with Flutter, view our online [documentation](https://flutter.io/).

For help on editing package code, view the [documentation](https://flutter.io/developing-packages/).
