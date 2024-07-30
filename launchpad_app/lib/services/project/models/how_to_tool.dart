import 'package:launchpad_app/extensions/json_typedef.dart';

/// Represents a tool in the HowTo schema.
class HowToTool {
  /// The name of the tool.
  final String name;

  /// Creates an instance of [HowToTool].
  HowToTool({required this.name});

  /// Creates an instance of [HowToTool] from a JSON object.
  factory HowToTool.fromJson(Map<String, dynamic> json) {
    return HowToTool(
      name: json['name'] as String,
    );
  }

  /// Converts the tool to a JSON object.
  JSONObject toJson() {
    return {
      'name': name,
    };
  }
}
