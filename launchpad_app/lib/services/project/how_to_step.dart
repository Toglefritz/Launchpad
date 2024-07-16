import 'package:launchpad_app/services/project/how_to_direction.dart';

/// Represents a step in the HowTo schema.
class HowToStep {
  /// The name of the step.
  final String name;

  /// The list of directions or sub-steps within the step.
  final List<HowToDirection> itemListElement;

  /// Creates an instance of [HowToStep].
  HowToStep({required this.name, required this.itemListElement});

  /// Creates an instance of [HowToStep] from a JSON object.
  factory HowToStep.fromJson(Map<String, dynamic> json) {
    return HowToStep(
      name: json['name'] as String,
      itemListElement: (json['itemListElement'] as List<dynamic>)
          .map((directionJson) => HowToDirection.fromJson(directionJson as Map<String, dynamic>))
          .toList(),
    );
  }
}
