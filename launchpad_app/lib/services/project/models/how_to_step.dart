import 'package:launchpad_app/services/project/models/how_to_direction.dart';
import 'package:launchpad_app/services/project/models/how_to_supply.dart';
import 'package:launchpad_app/services/project/models/how_to_tool.dart';

/// Represents a step in the HowTo schema.
// ignore_for_file: always_put_required_named_parameters_first
class HowToStep {
  /// The name of the step.
  final String name;

  /// A brief description of the step. This field is optional.
  final String? description;

  /// The list of directions or sub-steps within the step.
  final List<HowToDirection> directions;

  /// A list of tools required for the step.
  final List<HowToTool>? tools;

  /// A list of supplies required for the step.
  final List<HowToSupply>? supplies;

  /// Creates an instance of [HowToStep].
  HowToStep({
    required this.name,
    this.description,
    required this.directions,
    this.tools,
    this.supplies,
  });

  /// Creates an instance of [HowToStep] from a JSON object.
  factory HowToStep.fromJson(Map<String, dynamic> json) {
    return HowToStep(
      name: json['name'] as String,
      description: json['description'] as String?,
      directions: (json['itemListElement'] as List<dynamic>)
          .map((directionJson) => HowToDirection.fromJson(directionJson as Map<String, dynamic>))
          .toList(),
      tools: json['tool'] != null
          ? (json['tool'] as List<dynamic>)
              .map((toolJson) => HowToTool.fromJson(toolJson as Map<String, dynamic>))
              .toList()
          : null,
      supplies: json['supply'] != null
          ? (json['supply'] as List<dynamic>)
              .map((supplyJson) => HowToSupply.fromJson(supplyJson as Map<String, dynamic>))
              .toList()
          : null,
    );
  }
}
