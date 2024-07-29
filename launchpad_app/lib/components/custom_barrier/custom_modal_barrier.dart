import 'package:flutter/material.dart';
import 'package:launchpad_app/components/custom_barrier/lines_painter.dart';

/// A custom widget that overlays a modal barrier with decorative lines on top of the content
/// of a page but below the dialog when a dialog is displayed.
///
/// This widget is designed to provide a unique visual effect by drawing diagonal lines
/// across the screen. The lines are drawn using the [LinesPainter] class, which creates
/// parallel lines angled at 30 degrees.
class CustomModalBarrier extends StatelessWidget {
  /// The child widget that this barrier will overlay.
  ///
  /// Typically, this child will be the content of the page that should remain visible
  /// behind the dialog and barrier.
  final Widget child;

  /// Creates a [CustomModalBarrier] widget.
  ///
  /// The [child] parameter must not be null.
  const CustomModalBarrier({
    required this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // The custom painter responsible for drawing the lines on the modal barrier.
        Positioned.fill(
          child: CustomPaint(
            painter: LinesPainter(),
          ),
        ),
        // The child widget that will be overlaid by the modal barrier.
        child,
      ],
    );
  }
}
