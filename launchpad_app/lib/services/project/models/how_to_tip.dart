/// Represents a tip in the HowTo schema.
class HowToTip {
  /// The tip content.
  final String text;

  /// Creates an instance of [HowToTip].
  HowToTip({required this.text});

  /// Creates an instance of [HowToTip] from a JSON object.
  factory HowToTip.fromJson(Map<String, dynamic> json) {
    return HowToTip(
      text: json['text'] as String,
    );
  }
}
