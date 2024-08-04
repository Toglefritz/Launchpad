import 'package:flutter/cupertino.dart';

import 'package:launchpad_app/components/confetti/confetti_particle.dart';

/// Custom painter for drawing confetti particles on a canvas.
class ConfettiPainter extends CustomPainter {
  /// The list of particles to be drawn.
  final List<ConfettiParticle> particles;

  /// The current progress of the animation from 0.0 to 1.0.
  final double progress;

  /// Creates a [ConfettiPainter] with the given particles and progress.
  ConfettiPainter({
    required this.particles,
    required this.progress,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint();

    // Draw each particle on the canvas
    for (final ConfettiParticle particle in particles) {
      if (particle.lifespan > 0) {
        particle.update(0.016); // Assuming 60fps, so each frame is ~0.016 seconds

        paint.color = particle.color;
        canvas.drawCircle(
          Offset(particle.position.x, particle.position.y),
          3.0,
          paint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;

  @override
  bool shouldRebuildSemantics(CustomPainter oldDelegate) => false;
}
