import 'package:flutter/material.dart';
import 'package:launchpad_app/components/loader/delay_tween.dart';
import 'package:launchpad_app/components/loader/scale_y.dart';

/// A widget that displays a wave animation consisting of multiple bars that scale vertically.
///
/// This widget can be customized with a color, size, number of bars, animation type, and animation duration.
class WaveLoadingIndicator extends StatefulWidget {
  /// Creates a wave animation with the given parameters.
  ///
  /// [size] specifies the overall size of the wave animation.
  /// [duration] specifies the duration of the animation cycle.
  /// [controller] allows for providing a custom animation controller.
  const WaveLoadingIndicator({
    super.key,
    this.size = 50.0,
    this.duration = const Duration(milliseconds: 1200),
    this.controller,
  });

  /// The overall size of the wave animation.
  final double size;

  /// The duration of the animation cycle.
  final Duration duration;

  /// The custom animation controller.
  final AnimationController? controller;

  @override
  State<WaveLoadingIndicator> createState() => _WaveLoadingIndicatorState();
}

/// The state for the [WaveLoadingIndicator] widget.
class _WaveLoadingIndicatorState extends State<WaveLoadingIndicator> with SingleTickerProviderStateMixin {
  /// The animation controller for this widget.
  late AnimationController _controller;

  /// Determines the number of bars in the wave animation.
  final int itemCount = 3;

  @override
  void initState() {
    super.initState();
    _controller = (widget.controller ?? AnimationController(vsync: this, duration: widget.duration))..repeat();
  }

  @override
  Widget build(BuildContext context) {
    final List<double> bars = _animationDelay(itemCount);
    return Center(
      child: SizedBox.fromSize(
        size: Size(widget.size * 1.25, widget.size),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(bars.length, (i) {
            return ScaleY(
              scaleY: DelayTween(
                begin: .4,
                end: 1.0,
                delay: bars[i],
              ).animate(_controller),
              child: SizedBox.fromSize(
                size: Size(widget.size / itemCount, widget.size),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColorDark,
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  /// Returns a list of delays for the animation.
  List<double> _animationDelay(int count) {
    return <double>[
      ...List<double>.generate(
        count ~/ 2,
        (index) => -1.0 + (index * 0.2) + 0.2,
      ).reversed,
      if (count.isOdd) -1.0,
      ...List<double>.generate(
        count ~/ 2,
        (index) => -1.0 + (index * 0.2) + 0.2,
      ),
    ];
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }
}
