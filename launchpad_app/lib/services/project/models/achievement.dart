import 'package:launchpad_app/extensions/json_typedef.dart';

/// Represents an achievement for a project.
///
/// Achievements are awarded to users when they complete certain steps in a project. Each achievement has a title and a
/// description. The title is a short, descriptive name for the achievement, while the description provides more
/// information about the achievement and the step that must be completed to unlock it. Additionally, each achievement
/// has a step ID that corresponds to the ID of the step that must be completed to unlock the achievement.
class Achievement {
  /// The unique ID of the step that must be completed to unlock the achievement.
  final String stepId;

  /// The name of the achievement.
  final String title;

  /// A description of the achievement.
  final String description;

  /// Creates an [Achievement] object.
  Achievement({
    required this.stepId,
    required this.title,
    required this.description,
  });

  /// Creates an [Achievement] object from a JSON object.
  factory Achievement.fromJson(JSONObject json) {
    return Achievement(
      stepId: json['id'] as String,
      title: json['name'] as String,
      description: json['description'] as String,
    );
  }

  /// Converts the achievement to a JSON object.
  JSONObject toJson() {
    return <String, dynamic>{
      'id': stepId,
      'name': title,
      'description': description,
    };
  }
}
