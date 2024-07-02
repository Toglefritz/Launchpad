import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

/// A widget that scales its child widget vertically based on an animation.
///
/// This widget listens to an [Animation<double>] and scales its child widget along the Y axis.
class ScaleY extends AnimatedWidget {
  /// Creates a [ScaleY] with the given [scaleY] animation and child widget.
  ///
  /// [alignment] specifies the alignment of the transformation.
  const ScaleY({
    required Animation<double> scaleY,
    required this.child,
    super.key,
    this.alignment = Alignment.center,
  }) : super(listenable: scaleY);

  /// The child widget to be scaled.
  final Widget child;

  /// The alignment of the transformation.
  final Alignment alignment;

  /// The animation that drives the scaling transformation.
  Animation<double> get scale => listenable as Animation<double>;

  @override
  Widget build(BuildContext context) {
    return Transform(
      transform: Matrix4.identity()..scale(1.0, scale.value, 1.0),
      alignment: alignment,
      child: child,
    );
  }
}
