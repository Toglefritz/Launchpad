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
}