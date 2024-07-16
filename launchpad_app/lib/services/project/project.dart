import 'package:launchpad_app/services/project/how_to_step.dart';
import 'package:launchpad_app/services/project/how_to_supply.dart';
import 'package:launchpad_app/services/project/how_to_tip.dart';
import 'package:launchpad_app/services/project/how_to_tool.dart';

/// Represents a project following the schema.org HowTo schema. This class includes all the major fields from the
/// schema.org HowTo schema and provides a factory constructor to create instances from JSON content.
class Project {
  /// The name of the project.
  final String name;

  /// A brief description of the project.
  final String description;

  /// The list of steps required to complete the project.
  // TODO(Toglefritz): consider supporting HowToSection as well.
  final List<HowToStep>? steps;

  /// The list of tools needed for the project.
  final List<HowToTool>? tools;

  /// The list of supplies needed for the project.
  final List<HowToSupply>? supplies;

  /// The list of tips to help users complete the project.
  final List<HowToTip>? tips;

  /// The total time required to complete the project.
  final String? totalTime;

  /// Creates an instance of [Project].
  Project({
    required this.name,
    required this.description,
    required this.steps,
    this.tools,
    this.supplies,
    this.tips,
    this.totalTime,
  });

  /// Creates an instance of [Project] from a JSON object.
  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      name: json['name'] as String,
      description: json['description'] as String,
      steps: (json['step'] as List<dynamic>)
          .map((stepJson) => HowToStep.fromJson(stepJson as Map<String, dynamic>))
          .toList(),
      tools: (json['tool'] as List<dynamic>)
          .map((toolJson) => HowToTool.fromJson(toolJson as Map<String, dynamic>))
          .toList(),
      supplies: (json['supply'] as List<dynamic>)
          .map((supplyJson) => HowToSupply.fromJson(supplyJson as Map<String, dynamic>))
          .toList(),
      tips:
          (json['tip'] as List<dynamic>).map((tipJson) => HowToTip.fromJson(tipJson as Map<String, dynamic>)).toList(),
      totalTime: json['totalTime'] as String,
    );
  }
}
