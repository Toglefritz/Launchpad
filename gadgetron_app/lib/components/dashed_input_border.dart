import 'dart:ui';

import 'package:flutter/material.dart';

/// A custom [InputBorder] that creates a dashed border around a [TextField].
///
/// This border can be customized to adjust the dash width, dash gap, stroke width, color, and corner radius. It
/// extends the [InputBorder] class, making it easy to use in the `decoration` property of a [TextField] or at the
/// theme level using [InputDecorationTheme].
class DashedInputBorder extends InputBorder {
  /// The padding between the border and the text field content.
  final double gapPadding;

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

  /// The default border radius for the dashed border.
  static const _defaultBorderRadius = BorderRadius.all(Radius.circular(12.0));

  /// Creates a dashed border with the given properties.
  ///
  /// [gapPadding] defines the padding between the border and the text field content.
  /// [color] defines the color of the dashed border.
  /// [strokeWidth] defines the width of the border stroke.
  /// [dashWidth] defines the width of each dash segment.
  /// [dashGap] defines the gap between each dash segment.
  /// [borderRadius] defines the radius of the border's corners.
  const DashedInputBorder({
    this.gapPadding = 4.0,
    this.color = Colors.black,
    this.strokeWidth = 1.0,
    this.dashWidth = 5.0,
    this.dashGap = 3.0,
    this.borderRadius = _defaultBorderRadius,
    super.borderSide = const BorderSide(),
  });

  /// Creates a copy of this input border with the specified properties replaced.
  ///
  /// This method is used to create a new instance of the border with modified properties. It helps maintain
  /// immutability and allows for easy customization.
  @override
  DashedInputBorder copyWith({BorderSide? borderSide}) {
    return DashedInputBorder(
      gapPadding: gapPadding,
      color: color,
      strokeWidth: strokeWidth,
      dashWidth: dashWidth,
      dashGap: dashGap,
      borderRadius: borderRadius,
      borderSide: borderSide ?? this.borderSide,
    );
  }

  /// Gets the dimensions of the border, defined by [gapPadding].
  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.all(gapPadding);

  /// Indicates that this border is an outline border.
  ///
  /// This property is used by Flutter to determine how to paint the border.
  @override
  bool get isOutline => true;

  /// Paints the dashed border around the given [rect].
  ///
  /// This method is called by Flutter when the border needs to be rendered.
  /// It creates a path with dashed segments and draws it on the canvas.
  ///
  /// [canvas] is the drawing surface.
  /// [rect] is the bounding rectangle for the border.
  /// [gapStart], [gapExtent], [gapPercentage], and [textDirection] are
  /// additional parameters that provide context for the painting process.
  @override
  void paint(
    Canvas canvas,
    Rect rect, {
    double? gapStart,
    double gapExtent = 0.0,
    double? gapPercentage,
    TextDirection? textDirection,
  }) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final RRect outer = borderRadius.toRRect(rect);
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

  /// Gets the inner path of the border.
  ///
  /// This method is called by Flutter to determine the inner boundary of the border.
  /// It returns a path that outlines the inner boundary of the border.
  ///
  /// [rect] is the bounding rectangle for the border.
  /// [textDirection] provides the text direction for the border.
  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    return Path()
      ..addRRect(
        borderRadius.toRRect(rect).deflate(strokeWidth),
      );
  }

  /// Gets the outer path of the border.
  ///
  /// This method is called by Flutter to determine the outer boundary of the border.
  /// It returns a path that outlines the outer boundary of the border.
  ///
  /// [rect] is the bounding rectangle for the border.
  /// [textDirection] provides the text direction for the border.
  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    return Path()
      ..addRRect(
        borderRadius.toRRect(rect),
      );
  }

  /// Scales the border by the given factor [t].
  ///
  /// This method is called by Flutter to scale the border. It returns a new instance of the border with dimensions
  /// scaled by [t].
  @override
  ShapeBorder scale(double t) {
    return DashedInputBorder(
      gapPadding: gapPadding * t,
      color: color,
      strokeWidth: strokeWidth * t,
      dashWidth: dashWidth * t,
      dashGap: dashGap * t,
      borderRadius: borderRadius * t,
      borderSide: borderSide.scale(t),
    );
  }
}
