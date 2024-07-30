import 'package:launchpad_app/extensions/json_typedef.dart';
import 'package:launchpad_app/services/project/models/how_to_direction.dart';
import 'package:launchpad_app/services/project/models/how_to_supply.dart';
import 'package:launchpad_app/services/project/models/how_to_tool.dart';
import 'package:launchpad_app/services/uuid/uuid_generator.dart';

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
  HowToStep._({
    required this.id,
    required this.name,
    this.description,
    required this.directions,
    this.tools,
    this.supplies,
  });

  /// Creates an instance of [HowToStep] from a JSON object.
  factory HowToStep.fromJson(JSONObject json) {
    // Generate a unique identifier for the step, which is a random UUID.
    final String id = UuidGenerator.generateUuid();

    return HowToStep._(
      id: id,
      name: json['name'] as String,
      description: json['description'] as String?,
      directions: (json['itemListElement'] as List<dynamic>)
          .map((directionJson) => HowToDirection.fromJson(directionJson as JSONObject))
          .toList(),
      tools: json['tool'] != null
          ? (json['tool'] as List<dynamic>).map((toolJson) => HowToTool.fromJson(toolJson as JSONObject)).toList()
          : null,
      supplies: json['supply'] != null
          ? (json['supply'] as List<dynamic>)
              .map((supplyJson) => HowToSupply.fromJson(supplyJson as JSONObject))
              .toList()
          : null,
    );
  }

  /// Converts the step to a JSON object.
  JSONObject toJson() {
    final JSONObject json = {
      'id': id,
      'name': name,
      'description': description,
      'itemListElement': directions.map((HowToDirection direction) => direction.toJson()).toList(),
    };

    if (tools != null) {
      json['tool'] = tools!.map((HowToTool tool) => tool.toJson()).toList();
    }

    if (supplies != null) {
      json['supply'] = supplies!.map((HowToSupply supply) => supply.toJson()).toList();
    }

    return json;
  }

  /// Returns a boolean that indicates if the step is completed. A step is completed when all of its directions are
  /// completed.
  bool get isCompleted => directions.every((direction) => direction.isComplete);
}
