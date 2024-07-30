import 'package:launchpad_app/extensions/json_typedef.dart';

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

  /// Converts the tip to a JSON object.
  JSONObject toJson() {
    return {
      'text': text,
    };
  }
}
