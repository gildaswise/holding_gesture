# holding_gesture

A customized GestureDetector that acts on holding a determined Widget.

## Getting Started

```dart
import 'package:holding_gesture/holding_gesture.dart';
```

### HoldDetector

After importing, all you have to do is use `HoldDetector` the same way you already used `GestureDetector`! As it is on the documentation, its `onTap` override won't work when using a child that has `onPressed` or a similar callback, so you should pass the single tap behaviour to that.


```dart
HoldDetector(
  onHold: _incrementCounter,
  holdTimeout: Duration(milliseconds: 200),
  enableHapticFeedback: true,
  child: ElevatedButton(
    onPressed: _incrementCounter,
    child: Text("onHold"),
  ),
),
```

### HoldTimeoutDetector

`HoldTimeoutDetector` works differently, you can use it to hold conditions or display something while the user is holding it for a predetermined time, and then execute an action after this duration passes, or canceling it if the hold action ceases. In the example, I'm using it to show a feedback on the button, and on the screen that something is loading, and then executing the increment once the timeout happens.

```dart
HoldTimeoutDetector(
  onTimeout: () {
    _incrementCounter();
    _updateLoading(false);
  },
  onTimerInitiated: () => _updateLoading(true),
  onCancel: () => _updateLoading(false),
  holdTimeout: Duration(milliseconds: 3000),
  enableHapticFeedback: true,
  child: ElevatedButton.icon(
    onPressed: () {},
    label: Text("onTimeout"),
    icon: _isLoading
        ? SizedBox(
            width: 16,
            height: 16,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation(Colors.white),
            ),
          )
        : Icon(Icons.timer_3),
  ),
),
```

The main example, above and in `example/`, is the same as the default Flutter app, with the adition of a haptic feedback to each tick and the ability to hold the button to keep adding to the counter.
