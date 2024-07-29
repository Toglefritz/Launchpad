import 'package:flutter/material.dart';
import 'package:launchpad_app/components/custom_barrier/custom_modal_barrier.dart';

/// A custom painter that draws diagonal lines on a canvas.
///
/// This painter is used to create a decorative effect for the [CustomModalBarrier] widget. The lines are drawn at a
/// 30-degree angle, with a width of 2px and spaced 10px apart. The color of the lines is [Colors.grey.shade900].
class LinesPainter extends CustomPainter {
  /// Paints the diagonal lines on the canvas.
  ///
  /// The [canvas] is the area on which the lines are drawn, and the [size] parameter specifies the size of the canvas.
  /// The lines are drawn using a [Paint] object with the color set to [Colors.grey.shade900] and a stroke width of
  /// 2px. The lines are angled at 30 degrees and spaced 10px apart.
  @override
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.grey.shade800
      ..strokeWidth = 2.0;

    // Calculate the total number of lines needed to cover the screen
    final double totalDistance = size.width + size.height;
    final int lineCount = (totalDistance / 10).ceil();

    // Draw lines across the entire canvas
    for (int i = 0; i < lineCount; i++) {
      final double dx = i * 15.0;

      // Starting points for lines on the left edge and top edge of the canvas
      final Offset start = Offset(dx, 0);
      final Offset end = Offset(0, dx);

      // Draw lines from top-left to bottom-right
      canvas..drawLine(start, Offset(dx + size.height, size.height), paint)
      ..drawLine(end, Offset(size.width, dx + size.width), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
