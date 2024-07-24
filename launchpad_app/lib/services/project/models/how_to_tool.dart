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
}
