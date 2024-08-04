import 'dart:math';

import 'package:flutter/material.dart';
import 'package:launchpad_app/components/confetti/confetti_painter.dart';
import 'package:launchpad_app/components/confetti/confetti_particle.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

/// A widget that creates a decorative spray of confetti.
/// The widget itself is invisible but it exists at a particular location on the screen.
/// The confetti particles follow realistic physics and the widget is optimized for performance.
class ConfettiCannon extends StatefulWidget {
  /// The direction of the confetti spray as a unit vector.
  final vector.Vector2 direction;

  /// The number of confetti particles to be generated.
  final int particleCount;

  /// The spread amount of the confetti spray in radians.
  final double spread;

  /// The initial velocity of the confetti particles.
  final double initialVelocity;

  /// The duration over which all confetti particles will be launched.
  final Duration duration;

  /// The degree of randomness to be introduced to these parameters for each confetti particle.
  final double randomness;

  /// Creates a [ConfettiCannon] widget.
  const ConfettiCannon({
    required this.direction,
    this.particleCount = 100,
    this.spread = pi / 4,
    this.initialVelocity = 300,
    this.duration = const Duration(seconds: 3),
    this.randomness = 0.5,
    super.key,
  });

  @override
  ConfettiCannonState createState() => ConfettiCannonState();
}

/// State class for [ConfettiCannon].
class ConfettiCannonState extends State<ConfettiCannon> with SingleTickerProviderStateMixin {
  /// The animation controller for the confetti spray.
  late AnimationController _controller;

  /// The list of confetti particles to be generated.
  late List<ConfettiParticle> _particles;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    )..addListener(() {
        setState(() {});
      });

    // Generate confetti particles with random directions and velocities.
    _particles = List.generate(widget.particleCount, (index) {
      final Random random = Random();
      final vector.Vector2 direction = widget.direction +
          vector.Vector2(
                (random.nextDouble() - 0.5) * widget.spread,
                (random.nextDouble() - 0.5) * widget.spread,
              ).normalized() *
              widget.randomness;

      return ConfettiParticle(
        position: vector.Vector2(0, 0),
        velocity: direction * widget.initialVelocity * (1 + random.nextDouble() * widget.randomness),
        lifespan: widget.duration.inMilliseconds.toDouble(),
        color: Colors.primaries[random.nextInt(Colors.primaries.length)],
      );
    });

    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: ConfettiPainter(
        particles: _particles,
        progress: _controller.value,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
