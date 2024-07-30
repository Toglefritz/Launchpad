import 'package:launchpad_app/extensions/json_typedef.dart';
import 'package:launchpad_app/services/project/models/how_to_step.dart';
import 'package:launchpad_app/services/project/models/how_to_supply.dart';
import 'package:launchpad_app/services/project/models/how_to_tip.dart';
import 'package:launchpad_app/services/project/models/how_to_tool.dart';

/// Represents a project following the schema.org HowTo schema. This class includes all the major fields from the
/// schema.org HowTo schema and provides a factory constructor to create instances from JSON content.
class Project {
  /// The name of the project.
  final String name;

  /// A brief description of the project.
  final String description;

  /// The list of steps required to complete the project.
  // TODO(Toglefritz): consider supporting HowToSection as well.
  final List<HowToStep> steps;

  /// The list of tools needed for the project. The project itself can have a list of tools as well as each step.
  final List<HowToTool>? tools;

  /// The list of supplies needed for the project. The project itself can have a list of supplies as well as each step.
  final List<HowToSupply>? supplies;

  /// The list of tips to help users complete the project.
  final List<HowToTip>? tips;

  /// Creates an instance of [Project].
  Project({
    required this.name,
    required this.description,
    required this.steps,
    this.tools,
    this.supplies,
    this.tips,
  });

  /// Creates an instance of [Project] from a JSON object.
  factory Project.fromJson(JSONObject json) {
    return Project(
      name: json['name'] as String,
      description: json['description'] as String,
      steps: (json['step'] as JSONArray).map((stepJson) => HowToStep.fromJson(stepJson as JSONObject)).toList(),
      tools: (json['tool'] as JSONArray?)?.map((toolJson) => HowToTool.fromJson(toolJson as JSONObject)).toList(),
      supplies:
          (json['supply'] as JSONArray?)?.map((supplyJson) => HowToSupply.fromJson(supplyJson as JSONObject)).toList(),
      tips: (json['tip'] as JSONArray?)?.map((tipJson) => HowToTip.fromJson(tipJson as JSONObject)).toList(),
    );
  }
}
