part of 'package:holding_gesture/holding_gesture.dart';

/// Signature for when a pointer has remained in contact with the screen at the
/// same location for a long period of time.
typedef void GestureHoldTimeoutCallback();

/// Signature for when the pointer that previously triggered a
/// [GestureTapDownCallback] will not end up causing a tap.
///
/// See also:
///
///  * [GestureDetector.onTapCancel], which matches this signature.
///  * [TapGestureRecognizer], which uses this signature in one of its callbacks.
typedef void GestureHoldTimeoutCancelCallback();

const int kHoldTimeoutMilliseconds = 1000;
const Duration kHoldTimeoutDuration =
    const Duration(milliseconds: kHoldMilliseconds);

/// Recognizes when the user has pressed down at the same location for a long
/// period of time. Its waiting duration defaults to [kHoldTimeoutDuration].
class HoldTimeoutGestureRecognizer extends PrimaryPointerGestureRecognizer {
  /// Creates a long-press gesture recognizer.
  ///
  /// Consider assigning the [onTimeout] callback after creating this object.
  HoldTimeoutGestureRecognizer({
    this.timeout = kHoldTimeout,
    this.enableHapticFeedback = false,
    Object? debugOwner,
  }) : super(deadline: kHoldTimeout, debugOwner: debugOwner);

  /// The periodic time for each tick
  final Duration? timeout;

  /// Whether or not to get a haptic feedback on each tick
  final bool enableHapticFeedback;

  /// Called when the set duration is over.
  GestureHoldTimeoutCallback? onTimeout;

  /// Called when the timer starts.
  GestureHoldTimeoutCallback? onTimerInitiated;

  /// Called when the hold is canceled.
  GestureHoldTimeoutCancelCallback? onCancel;

  /// Used to figure out when to call parent's stopTrackingPointer method
  bool pointerUp = false;

  ///
  Timer? _timer;

  @override
  void didExceedDeadline() {
    resolve(GestureDisposition.accepted);
    if (onTimerInitiated != null && onTimeout != null) {
      invokeCallback<void>('onTimerInitiated', onTimerInitiated!);
      _timer = Timer.periodic(timeout ?? kHoldTimeout, (timer) {
        if (timer.isActive) {
          if (this.enableHapticFeedback) HapticFeedback.selectionClick();
          invokeCallback<void>('onTimeout', onTimeout!);
          timer.cancel();
        }
      });
    }
  }

  @override
  void stopTrackingPointer(int pointer) {
    if (pointerUp) {
      super.stopTrackingPointer(pointer);
      pointerUp = false;
    }
  }

  @override
  void resolve(GestureDisposition disposition) {
    super.resolve(disposition);
  }

  @override
  void handlePrimaryPointer(PointerEvent event) {
    if (event is PointerUpEvent ||
        event is PointerCancelEvent ||
        event is PointerRemovedEvent) {
      pointerUp = true;
      if (onCancel != null) invokeCallback<void>('onCancel', onCancel!);
      _timer?.cancel();
      resolve(GestureDisposition.rejected);
    }
  }

  @override
  String get debugDescription => 'hold-timeout';
}
