part of 'package:holding_gesture/holding_gesture.dart';

/// A widget that detects a holding gesture with a timeout.
///
/// If this widget has a child, it defers to that child for its sizing behavior.
/// If it does not have a child, it grows to fit the parent instead.
///
/// It defaults to executing an action after 1000ms (customizable).
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
/// HoldTimeoutDetector(
///   onTimeout: _incrementCounter,
///   child: FloatingActionButton(
///     child: Icon(Icons.add),
///     onPressed: _incrementCounter,
///   ),
/// )
/// ```
///
/// This example makes the counter add 1 once the 1000ms passed:
///
/// ```dart
/// HoldTimeoutDetector(
///   onTimeout: () {
///     setState(() { _counter += 1; });
///   },
///   child: Text("$_counter"),
/// )
/// ```
///
class HoldTimeoutDetector extends StatelessWidget {
  final GestureTapCallback? onTap;
  final GestureHoldTimeoutCallback onTimeout;
  final GestureHoldTimeoutCallback onTimerInitiated;
  final GestureHoldTimeoutCancelCallback? onCancel;

  final Duration? holdTimeout;

  final HitTestBehavior behavior;
  final bool enableHapticFeedback;
  final bool excludeFromSemantics;

  final Widget child;

  const HoldTimeoutDetector({
    Key? key,
    this.onTap,
    this.onCancel,
    this.holdTimeout,
    this.behavior = HitTestBehavior.translucent,
    this.enableHapticFeedback = false,
    this.excludeFromSemantics = false,
    required this.onTimeout,
    required this.onTimerInitiated,
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
          (instance) => instance..onTap = this.onTap ?? this.onTimerInitiated,
        ),
        HoldTimeoutGestureRecognizer:
            GestureRecognizerFactoryWithHandlers<HoldTimeoutGestureRecognizer>(
          () => HoldTimeoutGestureRecognizer(
            timeout: this.holdTimeout,
            enableHapticFeedback: this.enableHapticFeedback,
            debugOwner: this,
          ),
          (instance) => instance
            ..onTimeout = this.onTimeout
            ..onTimerInitiated = this.onTimerInitiated
            ..onCancel = this.onCancel,
        )
      },
      child: this.child,
    );
  }
}
