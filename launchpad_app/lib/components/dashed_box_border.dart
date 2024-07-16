import 'dart:ui';

import 'package:flutter/material.dart';

/// A custom [BoxBorder] that creates a dashed border around a widget.
///
/// This border can be customized to adjust the dash width, dash gap, stroke width, color, and corner radius. It
/// extends the [BoxBorder] class, making it easy to use in various widgets like [Container], [DecoratedBox], or
/// [OutlinedButton].
class DashedBoxBorder extends BoxBorder {
  /// The color of the dashed border.
  final Color color;

  /// The width of the border stroke.
  final double strokeWidth;

  /// The width of each dash segment.
  final double dashWidth;

  /// The gap between each dash segment.
  final double dashGap;

  /// The radius of the border's corners.
  final BorderRadius borderRadius;

  /// Creates a dashed border with the given properties.
  ///
  /// [color] defines the color of the dashed border.
  /// [strokeWidth] defines the width of the border stroke.
  /// [dashWidth] defines the width of each dash segment.
  /// [dashGap] defines the gap between each dash segment.
  /// [borderRadius] defines the radius of the border's corners.
  const DashedBoxBorder({
    this.color = Colors.black,
    this.strokeWidth = 1.0,
    this.dashWidth = 5.0,
    this.dashGap = 3.0,
    this.borderRadius = const BorderRadius.all(Radius.circular(12.0)),
  });

  @override
  void paint(Canvas canvas, Rect rect, {BorderRadius? borderRadius, BoxShape? shape, TextDirection? textDirection}) {
    final Paint paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final BorderRadius radius = borderRadius ?? BorderRadius.circular(12.0);

    final RRect outer = radius.toRRect(rect);
    final Path path = Path()..addRRect(outer);
    final Path dashedPath = _createDashedPath(path);

    canvas.drawPath(dashedPath, paint);
  }

  /// Creates a dashed path from a solid path.
  Path _createDashedPath(Path source) {
    final List<double> dashArray = [dashWidth, dashGap];
    final Path dashedPath = Path();
    for (final PathMetric pathMetric in source.computeMetrics()) {
      double distance = 0.0;
      bool draw = true;
      while (distance < pathMetric.length) {
        final double length = dashArray[(draw ? 0 : 1) % dashArray.length];
        if (draw) {
          dashedPath.addPath(
            pathMetric.extractPath(distance, distance + length),
            Offset.zero,
          );
        }
        distance += length;
        draw = !draw;
      }
    }

    return dashedPath;
  }

  @override
  BoxBorder add(ShapeBorder other, {bool reversed = false}) {
    throw UnimplementedError('DashedBoxBorder cannot be combined with other borders.');
  }

  @override
  BoxBorder scale(double t) {
    return DashedBoxBorder(
      color: color,
      strokeWidth: strokeWidth * t,
      dashWidth: dashWidth * t,
      dashGap: dashGap * t,
      borderRadius: borderRadius * t,
    );
  }

  @override
  ShapeBorder? lerpFrom(ShapeBorder? a, double t) {
    // Implement lerpFrom if necessary for animation
    return super.lerpFrom(a, t);
  }

  @override
  ShapeBorder? lerpTo(ShapeBorder? b, double t) {
    // Implement lerpTo if necessary for animation
    return super.lerpTo(b, t);
  }

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.all(strokeWidth);

  @override
  BorderSide get bottom => BorderSide(color: color, width: strokeWidth);

  @override
  bool get isUniform => true;

  @override
  BorderSide get top => BorderSide(color: color, width: strokeWidth);
}
