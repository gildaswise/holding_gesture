part of 'package:holding_gesture/holding_gesture.dart';

///  * [IconButton], which combines [InkHoldingResponse] with an [Icon].
class InkHoldingResponse extends StatefulWidget {
  /// Creates an area of a [Material] that responds to touch.
  ///
  /// Must have an ancestor [Material] widget in which to cause ink reactions.
  ///
  /// The [containedInkWell], [highlightShape], [enableFeedback], and
  /// [excludeFromSemantics] arguments must not be null.
  const InkHoldingResponse({
    Key key,
    @required this.child,
    @required this.onHold,
    this.onTap,
    this.onCancel,
    this.holdTimeout,
    this.onHighlightChanged,
    this.containedInkWell = false,
    this.highlightShape = BoxShape.circle,
    this.radius,
    this.borderRadius,
    this.customBorder,
    this.highlightColor,
    this.splashColor,
    this.splashFactory,
    this.enableFeedback = true,
    this.excludeFromSemantics = false,
  })  : assert(containedInkWell != null),
        assert(highlightShape != null),
        assert(enableFeedback != null),
        assert(excludeFromSemantics != null),
        super(key: key);

  /// The widget below this widget in the tree.
  ///
  /// {@macro flutter.widgets.child}
  final Widget child;

  /// Called when the user taps this part of the material.
  final GestureTapCallback onTap;

  /// Called when the user cancels a tap that was started on this part of the
  /// material.
  final GestureHoldCancelCallback onCancel;

  /// Called when the user long-presses on this part of the material.
  final GestureHoldCallback onHold;

  final Duration holdTimeout;

  /// Called when this part of the material either becomes highlighted or stops
  /// being highlighted.
  ///
  /// The value passed to the callback is true if this part of the material has
  /// become highlighted and false if this part of the material has stopped
  /// being highlighted.
  final ValueChanged<bool> onHighlightChanged;

  /// Whether this ink response should be clipped its bounds.
  ///
  /// This flag also controls whether the splash migrates to the center of the
  /// [InkHoldingResponse] or not. If [containedInkWell] is true, the splash remains
  /// centered around the tap location. If it is false, the splash migrates to
  /// the center of the [InkHoldingResponse] as it grows.
  ///
  /// See also:
  ///
  ///  * [highlightShape], which determines the shape of the highlight.
  ///  * [borderRadius], which controls the corners when the box is a rectangle.
  ///  * [getRectCallback], which controls the size and position of the box when
  ///    it is a rectangle.
  final bool containedInkWell;

  /// The shape (e.g., circle, rectangle) to use for the highlight drawn around
  /// this part of the material.
  ///
  /// If the shape is [BoxShape.circle], then the highlight is centered on the
  /// [InkHoldingResponse]. If the shape is [BoxShape.rectangle], then the highlight
  /// fills the [InkHoldingResponse], or the rectangle provided by [getRectCallback] if
  /// the callback is specified.
  ///
  /// See also:
  ///
  ///  * [containedInkWell], which controls clipping behavior.
  ///  * [borderRadius], which controls the corners when the box is a rectangle.
  ///  * [highlightColor], the color of the highlight.
  ///  * [getRectCallback], which controls the size and position of the box when
  ///    it is a rectangle.
  final BoxShape highlightShape;

  /// The radius of the ink splash.
  ///
  /// Splashes grow up to this size. By default, this size is determined from
  /// the size of the rectangle provided by [getRectCallback], or the size of
  /// the [InkHoldingResponse] itself.
  ///
  /// See also:
  ///
  ///  * [splashColor], the color of the splash.
  ///  * [splashFactory], which defines the appearance of the splash.
  final double radius;

  /// The clipping radius of the containing rect. This is effective only if
  /// [customBorder] is null.
  ///
  /// If this is null, it is interpreted as [BorderRadius.zero].
  final BorderRadius borderRadius;

  /// The custom clip border which overrides [borderRadius].
  final ShapeBorder customBorder;

  /// The highlight color of the ink response. If this property is null then the
  /// highlight color of the theme, [ThemeData.highlightColor], will be used.
  ///
  /// See also:
  ///
  ///  * [highlightShape], the shape of the highlight.
  ///  * [splashColor], the color of the splash.
  ///  * [splashFactory], which defines the appearance of the splash.
  final Color highlightColor;

  /// The splash color of the ink response. If this property is null then the
  /// splash color of the theme, [ThemeData.splashColor], will be used.
  ///
  /// See also:
  ///
  ///  * [splashFactory], which defines the appearance of the splash.
  ///  * [radius], the (maximum) size of the ink splash.
  ///  * [highlightColor], the color of the highlight.
  final Color splashColor;

  /// Defines the appearance of the splash.
  ///
  /// Defaults to the value of the theme's splash factory: [ThemeData.splashFactory].
  ///
  /// See also:
  ///
  ///  * [radius], the (maximum) size of the ink splash.
  ///  * [splashColor], the color of the splash.
  ///  * [highlightColor], the color of the highlight.
  ///  * [InkSplash.splashFactory], which defines the default splash.
  ///  * [InkRipple.splashFactory], which defines a splash that spreads out
  ///    more aggressively than the default.
  final InteractiveInkFeatureFactory splashFactory;

  /// Whether detected gestures should provide acoustic and/or haptic feedback.
  ///
  /// For example, on Android a tap will produce a clicking sound and a
  /// long-press will produce a short vibration, when feedback is enabled.
  ///
  /// See also:
  ///
  ///  * [Feedback] for providing platform-specific feedback to certain actions.
  final bool enableFeedback;

  /// Whether to exclude the gestures introduced by this widget from the
  /// semantics tree.
  ///
  /// For example, a long-press gesture for showing a tooltip is usually
  /// excluded because the tooltip itself is included in the semantics
  /// tree directly and so having a gesture to show it would result in
  /// duplication of information.
  final bool excludeFromSemantics;

  /// The rectangle to use for the highlight effect and for clipping
  /// the splash effects if [containedInkWell] is true.
  ///
  /// This method is intended to be overridden by descendants that
  /// specialize [InkHoldingResponse] for unusual cases. For example,
  /// [TableRowInkWell] implements this method to return the rectangle
  /// corresponding to the row that the widget is in.
  ///
  /// The default behavior returns null, which is equivalent to
  /// returning the referenceBox argument's bounding box (though
  /// slightly more efficient).
  RectCallback getRectCallback(RenderBox referenceBox) => null;

  /// Asserts that the given context satisfies the prerequisites for
  /// this class.
  ///
  /// This method is intended to be overridden by descendants that
  /// specialize [InkHoldingResponse] for unusual cases. For example,
  /// [TableRowInkWell] implements this method to verify that the widget is
  /// in a table.
  @mustCallSuper
  bool debugCheckContext(BuildContext context) {
    assert(debugCheckHasMaterial(context));
    return true;
  }

  @override
  _InkHoldingResponseState<InkHoldingResponse> createState() =>
      new _InkHoldingResponseState<InkHoldingResponse>();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    final List<String> gestures = <String>[];
    if (onTap != null) gestures.add('tap');
    if (onHold != null) gestures.add('hold');
    properties
        .add(IterableProperty<String>('gestures', gestures, ifEmpty: '<none>'));
    properties.add(DiagnosticsProperty<bool>(
        'containedInkWell', containedInkWell,
        level: DiagnosticLevel.fine));
    properties.add(DiagnosticsProperty<BoxShape>(
      'highlightShape',
      highlightShape,
      description: '${containedInkWell ? "clipped to " : ""}$highlightShape',
      showName: false,
    ));
  }
}

class _InkHoldingResponseState<T extends InkHoldingResponse> extends State<T>
    with AutomaticKeepAliveClientMixin {
  Set<InteractiveInkFeature> _splashes;
  InteractiveInkFeature _currentSplash;
  InkHighlight _lastHighlight;

  @override
  bool get wantKeepAlive =>
      _lastHighlight != null || (_splashes != null && _splashes.isNotEmpty);

  void updateHighlight(bool value) {
    if (value == (_lastHighlight != null && _lastHighlight.active)) return;
    if (value) {
      if (_lastHighlight == null) {
        final RenderBox referenceBox = context.findRenderObject();
        _lastHighlight = new InkHighlight(
          controller: Material.of(context),
          referenceBox: referenceBox,
          color: widget.highlightColor ?? Theme.of(context).highlightColor,
          shape: widget.highlightShape,
          borderRadius: widget.borderRadius,
          customBorder: widget.customBorder,
          rectCallback: widget.getRectCallback(referenceBox),
          onRemoved: _handleInkHighlightRemoval,
        );
        updateKeepAlive();
      } else {
        _lastHighlight.activate();
      }
    } else {
      _lastHighlight.deactivate();
    }
    assert(value == (_lastHighlight != null && _lastHighlight.active));
    if (widget.onHighlightChanged != null) widget.onHighlightChanged(value);
  }

  InteractiveInkFeature _createInkFeature(TapDownDetails details) {
    final MaterialInkController inkController = Material.of(context);
    final RenderBox referenceBox = context.findRenderObject();
    final Offset position = referenceBox.globalToLocal(details.globalPosition);
    final Color color = widget.splashColor ?? Theme.of(context).splashColor;
    final RectCallback rectCallback =
        widget.containedInkWell ? widget.getRectCallback(referenceBox) : null;
    final BorderRadius borderRadius = widget.borderRadius;
    final ShapeBorder customBorder = widget.customBorder;

    InteractiveInkFeature splash;
    void onRemoved() {
      if (_splashes != null) {
        assert(_splashes.contains(splash));
        _splashes.remove(splash);
        if (_currentSplash == splash) _currentSplash = null;
        updateKeepAlive();
      } // else we're probably in deactivate()
    }

    splash = (widget.splashFactory ?? Theme.of(context).splashFactory).create(
      controller: inkController,
      referenceBox: referenceBox,
      position: position,
      color: color,
      containedInkWell: widget.containedInkWell,
      rectCallback: rectCallback,
      radius: widget.radius,
      borderRadius: borderRadius,
      customBorder: customBorder,
      onRemoved: onRemoved,
    );

    return splash;
  }

  void _handleTapDown(TapDownDetails details) {
    final InteractiveInkFeature splash = _createInkFeature(details);
    _splashes ??= new HashSet<InteractiveInkFeature>();
    _splashes.add(splash);
    _currentSplash = splash;
    updateKeepAlive();
    updateHighlight(true);
  }

  void _handleInkHighlightRemoval() {
    assert(_lastHighlight != null);
    _lastHighlight = null;
    updateKeepAlive();
  }

  void _handleTap(BuildContext context) {
    _currentSplash?.confirm();
    _currentSplash = null;
    updateHighlight(false);
    if (widget.enableFeedback) Feedback.forTap(context);
    if (widget.onTap == null)
      widget.onHold();
    else
      widget.onTap();
  }

  void _handleHold(BuildContext context) {
    _currentSplash?.confirm();
    _currentSplash = null;
    if (widget.onHold != null) {
      if (widget.enableFeedback) Feedback.forLongPress(context);
      widget.onHold();
    }
  }

  @override
  void deactivate() {
    if (_splashes != null) {
      final Set<InteractiveInkFeature> splashes = _splashes;
      _splashes = null;
      for (InteractiveInkFeature splash in splashes) splash.dispose();
      _currentSplash = null;
    }
    assert(_currentSplash == null);
    _lastHighlight?.dispose();
    _lastHighlight = null;
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    assert(widget.debugCheckContext(context));
    super.build(context); // See AutomaticKeepAliveClientMixin.
    final ThemeData themeData = Theme.of(context);
    _lastHighlight?.color = widget.highlightColor ?? themeData.highlightColor;
    _currentSplash?.color = widget.splashColor ?? themeData.splashColor;

    return RawGestureDetector(
      behavior: HitTestBehavior.opaque,
      excludeFromSemantics: widget.excludeFromSemantics,
      gestures: {
        TapGestureRecognizer:
            GestureRecognizerFactoryWithHandlers<TapGestureRecognizer>(
          () => TapGestureRecognizer(debugOwner: this),
          (instance) => instance
            ..onTap = (() => _handleTap(context))
            ..onTapDown = ((details) => _handleTapDown(details)),
        ),
        HoldGestureRecognizer:
            GestureRecognizerFactoryWithHandlers<HoldGestureRecognizer>(
          () => HoldGestureRecognizer(
                debugOwner: this,
              ),
          (instance) => instance
            ..onHold = (() => _handleHold(context))
            ..onCancel = widget.onCancel,
        )
      },
      child: widget.child,
    );
  }
}

class HoldableInkWell extends InkHoldingResponse {
  const HoldableInkWell({
    Key key,
    Widget child,
    GestureTapCallback onTap,
    GestureHoldCallback onHold,
    GestureHoldCancelCallback onCancel,
    ValueChanged<bool> onHighlightChanged,
    Color highlightColor,
    Color splashColor,
    InteractiveInkFeatureFactory splashFactory,
    double radius,
    BoxShape highlightShape,
    BorderRadius borderRadius,
    ShapeBorder customBorder,
    bool enableFeedback = true,
    bool excludeFromSemantics = false,
  }) : super(
          key: key,
          child: child,
          onTap: onTap,
          onCancel: onCancel,
          onHold: onHold,
          onHighlightChanged: onHighlightChanged,
          containedInkWell: true,
          highlightShape: highlightShape ?? BoxShape.rectangle,
          highlightColor: highlightColor,
          splashColor: splashColor,
          splashFactory: splashFactory,
          radius: radius,
          borderRadius: borderRadius,
          customBorder: customBorder,
          enableFeedback: enableFeedback,
          excludeFromSemantics: excludeFromSemantics,
        );
}
