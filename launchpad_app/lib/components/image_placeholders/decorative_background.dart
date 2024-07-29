import 'dart:math';
import 'package:flutter/material.dart';

/// A widget that displays a decorative background with random shapes and lines.
/// This background is designed to be used in place of an image, providing a unique
/// and abstract visual effect using a combination of `Colors.grey.shade100` with
/// 10% opacity on a `Colors.grey.shade900` background.
class DecorativeBackground extends StatelessWidget {
  /// Creates a [DecorativeBackground] widget.
  const DecorativeBackground({super.key});

  /// Creates a [DecorativeBackground] widget.
  ///
  /// The background effect is drawn using a [CustomPaint] widget, with the actual drawing logic implemented in the
  /// [_DecorativeBackgroundPainter] class.
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size.infinite, // Covers the entire available space
      painter: _DecorativeBackgroundPainter(),
    );
  }
}

/// A custom painter that draws a random decorative background consisting of various shapes. The shapes are drawn
/// using `Colors.grey.shade100` with 10% opacity on a `Colors.grey.shade900` background.
///
/// This painter draws the background when used in a [CustomPaint] widget.
class _DecorativeBackgroundPainter extends CustomPainter {
  /// A random number generator used to create random shapes.
  final Random _random = Random();

  /// Paints the random decorative background on the given [canvas] within the
  /// specified [size] area.
  ///
  /// This method is called whenever the framework determines that the painter needs to repaint. It draws a series of
  /// random circles and squares, using `Colors.grey.shade100` with 10% opacity for color.
  ///
  /// * [canvas] - The canvas on which to draw.
  /// * [size] - The size of the area within which to draw.
  @override
  void paint(Canvas canvas, Size size) {
    // Background color
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Paint()..color = Colors.grey.shade900,
    );

    // Draw random shapes
    for (int i = 0; i < 12; i++) {
      // Randomly choose to draw a circle or a square
      if (_random.nextBool()) {
        _drawRandomCircle(canvas, size);
      } else {
        _drawRandomSquare(canvas, size);
      }
    }
  }

  /// Draws a random circle on the given [canvas] within the specified [size] area.
  ///
  /// The circle is drawn with a random center position, radius, and color. The color is set to `Colors.grey.shade100`
  /// with 50% opacity.
  ///
  /// * [canvas] - The canvas on which to draw the circle.
  /// * [size] - The size of the area within which to draw the circle.
  void _drawRandomCircle(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.grey.shade100.withOpacity(0.5)
      ..style = PaintingStyle.fill;

    final Offset center = Offset(
      _random.nextDouble() * size.width,
      _random.nextDouble() * size.height,
    );

    final double radius = _random.nextDouble() * 50.0;

    canvas.drawCircle(center, radius, paint);
  }

  /// Draws a random square on the given [canvas] within the specified [size] area.
  ///
  /// The square is drawn with a random top-left position, size, and color. The color is set to `Colors.grey.shade100`
  /// with 10% opacity.
  ///
  /// * [canvas] - The canvas on which to draw the square.
  /// * [size] - The size of the area within which to draw the square.
  void _drawRandomSquare(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.grey.shade100.withOpacity(0.1)
      ..style = PaintingStyle.fill;

    final Offset topLeft = Offset(
      _random.nextDouble() * size.width,
      _random.nextDouble() * size.height,
    );

    final double sideLength = _random.nextDouble() * 50.0;

    canvas.drawRect(
      Rect.fromLTWH(topLeft.dx, topLeft.dy, sideLength, sideLength),
      paint,
    );
  }

  /// Returns whether this painter should repaint.
  ///
  /// In this implementation, the painter does not need to repaint, so this method always returns false.
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
