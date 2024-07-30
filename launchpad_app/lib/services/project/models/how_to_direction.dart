import 'package:launchpad_app/extensions/json_typedef.dart';
import 'package:launchpad_app/services/uuid/uuid_generator.dart';

/// Represents a direction in the HowTo schema.
class HowToDirection {
  /// A unique identifier for the direction.
  final String id;

  /// The detailed instructions for the direction.
  final String text;

  /// Determines if the direction has been completed.
  bool isComplete;

  /// Creates an instance of [HowToDirection].
  HowToDirection._({
    required this.id,
    required this.text,
    required this.isComplete,
  });

  /// Creates an instance of [HowToDirection] from a JSON object.
  factory HowToDirection.fromJson(Map<String, dynamic> json) {
    // Generate a unique identifier for the direction, which is a random UUID.
    final String id = UuidGenerator.generateUuid();

    return HowToDirection._(
      id: id,
      text: json['text'] as String,
      isComplete: json['complete'] as bool? ?? false,
    );
  }

  /// Converts the direction to a JSON object.
  JSONObject toJson() {
    return {
      'id': id,
      'text': text,
      'complete': isComplete,
    };
  }
}
