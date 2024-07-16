/// Represents a direction in the HowTo schema.
class HowToDirection {
  /// The detailed instructions for the direction.
  final String text;

  /// Creates an instance of [HowToDirection].
  HowToDirection({required this.text});

  /// Creates an instance of [HowToDirection] from a JSON object.
  factory HowToDirection.fromJson(Map<String, dynamic> json) {
    return HowToDirection(
      text: json['text'] as String,
    );
  }
}