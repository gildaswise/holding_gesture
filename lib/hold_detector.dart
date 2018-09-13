part of 'package:holding_gesture/holding_gesture.dart';

/// A widget that detects a holding gesture.
///
/// If this widget has a child, it defers to that child for its sizing behavior.
/// If it does not have a child, it grows to fit the parent instead.
///
/// It defaults to repeating an action every 200ms (customizable), but for now
/// it always waits 200ms to start repeating the [onHold] callback.
///
/// See <http://flutter.io/gestures/> for additional information.
///
/// Material design applications typically react to touches with ink splash
/// effects. The [InkWell] class implements this effect and can be used in place
/// of a [GestureDetector] for handling taps.
///
/// This example makes the counter keep while holding the button:
///
/// ```dart
/// new HoldDetector(
///   onHold: () {
///     setState(() { _counter += 1; });
///   },
///   child: Text("$_counter"),
/// )
/// ```
///
class HoldDetector extends StatelessWidget {
  final GestureTapCallback onTap;
  final GestureHoldCallback onHold;
  final GestureHoldCancelCallback onCancel;

  final Duration holdTimeout;

  final HitTestBehavior behavior;
  final bool excludeFromSemantics;

  final Widget child;

  const HoldDetector({
    Key key,
    this.onTap,
    this.onCancel,
    this.holdTimeout,
    this.behavior = HitTestBehavior.opaque,
    this.excludeFromSemantics = false,
    @required this.onHold,
    @required this.child,
  })  : assert(onHold != null),
        assert(child != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return RawGestureDetector(
      behavior: this.behavior,
      excludeFromSemantics: this.excludeFromSemantics,
      gestures: {
        TapGestureRecognizer:
            GestureRecognizerFactoryWithHandlers<TapGestureRecognizer>(
          () => TapGestureRecognizer(debugOwner: this),
          (instance) => instance..onTap = this.onTap,
        ),
        HoldGestureRecognizer:
            GestureRecognizerFactoryWithHandlers<HoldGestureRecognizer>(
          () => HoldGestureRecognizer(
                timeout: this.holdTimeout,
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