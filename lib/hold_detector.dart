part of 'package:holding_gesture/holding_gesture.dart';

/// A widget that detects a holding gesture.
///
/// If this widget has a child, it defers to that child for its sizing behavior.
/// If it does not have a child, it grows to fit the parent instead.
///
/// It defaults to repeating an action every 300ms (customizable), but for now
/// it always waits 300ms to start repeating the [onHold] callback.
///
/// See <http://flutter.io/gestures/> for additional information.
///
/// Material design applications typically react to touches with ink splash
/// effects. The [InkWell] class implements this effect and can be used in place
/// or with a [GestureDetector] for handling taps.
///
/// The `onTap` override won't work when the `child` has a `onPressed`
/// or similar property, so you might want to pass the same method
/// before, like this:
///
/// ```dart
/// HoldDetector(
///   onHold: _incrementCounter,
///   child: FloatingActionButton(
///     child: Icon(Icons.add),
///     onPressed: _incrementCounter,
///   ),
/// )
/// ```
///
/// This example makes the counter keep while holding the button:
///
/// ```dart
/// HoldDetector(
///   onHold: () {
///     setState(() { _counter += 1; });
///   },
///   child: Text("$_counter"),
/// )
/// ```
///
class HoldDetector extends StatelessWidget {
  final GestureTapCallback? onTap;
  final GestureHoldCallback onHold;
  final GestureHoldCancelCallback? onCancel;

  final Duration? holdTimeout;

  final HitTestBehavior behavior;
  final bool enableHapticFeedback;
  final bool excludeFromSemantics;

  final Widget child;

  const HoldDetector({
    Key? key,
    this.onTap,
    this.onCancel,
    this.holdTimeout,
    this.behavior = HitTestBehavior.translucent,
    this.enableHapticFeedback = false,
    this.excludeFromSemantics = false,
    required this.onHold,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RawGestureDetector(
      behavior: this.behavior,
      excludeFromSemantics: this.excludeFromSemantics,
      gestures: {
        TapGestureRecognizer:
            GestureRecognizerFactoryWithHandlers<TapGestureRecognizer>(
          () => TapGestureRecognizer(debugOwner: this),
          (instance) => instance..onTap = this.onTap ?? this.onHold,
        ),
        HoldGestureRecognizer:
            GestureRecognizerFactoryWithHandlers<HoldGestureRecognizer>(
          () => HoldGestureRecognizer(
            timeout: this.holdTimeout,
            enableHapticFeedback: this.enableHapticFeedback,
            debugOwner: this,
          ),
          (instance) => instance
            ..onHold = this.onHold
            ..onCancel = this.onCancel,
        )
      },
      child: this.child,
    );
  }
}
