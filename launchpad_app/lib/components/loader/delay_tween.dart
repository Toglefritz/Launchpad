import 'dart:math' as math show pi, sin;

import 'package:flutter/animation.dart';

/// A [Tween] that applies a delay to the interpolation of the animation's value.
///
/// The [DelayTween] class overrides the [lerp] and [evaluate] methods of the [Tween] class
/// to apply a sinusoidal delay to the interpolation of the animation's value.
class DelayTween extends Tween<double> {
  /// Creates a [DelayTween].
  ///
  /// The [begin] and [end] arguments represent the range of the animation's value,
  /// and the [delay] argument represents the delay to apply to the interpolation.
  DelayTween({
    required this.delay, super.begin,
    super.end,
  });

  /// The delay to apply to the interpolation of the animation's value.
  final double delay;

  /// Applies a sinusoidal delay to the interpolation of the animation's value.
  ///
  /// The [t] argument represents the current value of the animation.
  @override
  double lerp(double t) {
    return super.lerp((math.sin((t - delay) * 2 * math.pi) + 1) / 2);
  }

  /// Returns the interpolated value of the animation.
  ///
  /// The [animation] argument represents the animation.
  @override
  double evaluate(Animation<double> animation) => lerp(animation.value);
}
