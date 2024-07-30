import 'package:launchpad_app/extensions/json_typedef.dart';

/// Represents a supply in the HowTo schema.
class HowToSupply {
  /// The name of the supply.
  final String name;

  /// Creates an instance of [HowToSupply].
  HowToSupply({required this.name});

  /// Creates an instance of [HowToSupply] from a JSON object.
  factory HowToSupply.fromJson(Map<String, dynamic> json) {
    return HowToSupply(
      name: json['name'] as String,
    );
  }

  /// Converts the supply to a JSON object.
  JSONObject toJson() {
    return {
      'name': name,
    };
  }
}
