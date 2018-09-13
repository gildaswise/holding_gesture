part of 'package:holding_gesture/holding_gesture.dart';

/// Signature for when a pointer has remained in contact with the screen at the
/// same location for a long period of time.
typedef void GestureHoldCallback();

/// Signature for when the pointer that previously triggered a
/// [GestureTapDownCallback] will not end up causing a tap.
///
/// See also:
///
///  * [GestureDetector.onTapCancel], which matches this signature.
///  * [TapGestureRecognizer], which uses this signature in one of its callbacks.
typedef void GestureHoldCancelCallback();

final Duration kHoldTimeout = Duration(milliseconds: 200);

/// Recognizes when the user has pressed down at the same location for a long
/// period of time. Its waiting duration defaults to [kHoldTimeout].
class HoldGestureRecognizer extends PrimaryPointerGestureRecognizer {
  /// Creates a long-press gesture recognizer.
  ///
  /// Consider assigning the [onHold] callback after creating this object.
  HoldGestureRecognizer({this.timeout, Object debugOwner})
      : super(deadline: kHoldTimeout, debugOwner: debugOwner);

  final Duration timeout;

  /// Called when a hold is recognized.
  GestureHoldCallback onHold;

  /// Called when the hold is canceled.
  GestureHoldCancelCallback onCancel;

  ///
  Timer _timer;

  @override
  void didExceedDeadline() {
    resolve(GestureDisposition.accepted);
    if (onHold != null) {
      _timer = Timer.periodic(timeout ?? kHoldTimeout, (timer) {
        if (timer.isActive) invokeCallback<void>('onHold', onHold);
      });
    }
  }

  @override
  void handlePrimaryPointer(PointerEvent event) {
    if (event is PointerUpEvent ||
        event is PointerCancelEvent ||
        event is PointerRemovedEvent) {
      if (onCancel != null) invokeCallback<void>('onCancel', onCancel);
      _timer?.cancel();
      resolve(GestureDisposition.rejected);
    }
  }

  @override
  String get debugDescription => 'hold';
}

void resolve(accepted) {}
