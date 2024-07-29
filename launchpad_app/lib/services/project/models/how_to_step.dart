import 'package:launchpad_app/services/project/models/how_to_direction.dart';
import 'package:launchpad_app/services/project/models/how_to_supply.dart';
import 'package:launchpad_app/services/project/models/how_to_tool.dart';

/// Represents a project step, represented as a JSON file conforming to the HowToStep schema from schema.org. However,
/// for the purposes of the Launchpad app, the schema.org HowToStep schema is extended with additional fields that are
/// not part of the schema.org HowToStep schema. These additional fields are used to provide additional information to
/// the user when viewing the project.
// ignore_for_file: always_put_required_named_parameters_first
class HowToStep {
  /// A unique identifier for the step.
  final String id;

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
    required this.id,
    required this.name,
    this.description,
    required this.directions,
    this.tools,
    this.supplies,
  });

  /// Creates an instance of [HowToStep] from a JSON object.
  factory HowToStep.fromJson(Map<String, dynamic> json) {
    // Generate a unique identifier for the step, which is a hash of the step's original name.
    final String name = json['name'] as String;
    final String id = name.hashCode.toRadixString(16);

    return HowToStep(
      id: id,
      name: name,
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
