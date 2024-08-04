import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

/// Represents a single confetti particle with properties for position, velocity, lifespan, and color.
class ConfettiParticle {
  /// The current position of the particle.
  vector.Vector2 position;

  /// The current velocity of the particle.
  vector.Vector2 velocity;

  /// The remaining lifespan of the particle in milliseconds.
  double lifespan;

  /// The color of the particle.
  Color color;

  /// Creates a [ConfettiParticle] with the given properties.
  ConfettiParticle({
    required this.position,
    required this.velocity,
    required this.lifespan,
    required this.color,
  });

  /// Updates the particle's position and velocity based on the elapsed time.
  ///
  /// [deltaTime] is the elapsed time in seconds since the last update.
  void update(double deltaTime) {
    position += velocity * deltaTime;
    velocity += vector.Vector2(0, 98.1) * deltaTime; // Gravity effect
    lifespan -= deltaTime * 1000;
  }
}
