import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:launchpad_app/extensions/json_typedef.dart';
import 'package:launchpad_app/services/firebase_core/firebase_emulators_ip.dart';
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

  /// Determines if the step is active. It is assumed at only one step in the project is active at a time, otherwise
  /// the first active step is considered the active step.
  bool? active;

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
    this.active,
    required this.directions,
    this.tools,
    this.supplies,
  });

  /// Creates an instance of [HowToStep] from a JSON object.
  factory HowToStep.fromJson(JSONObject json) {
    // Generate a unique identifier for the step, which is a random UUID.
    final String id = json['id'] as String? ?? UuidGenerator.generateUuid();

    return HowToStep._(
      id: id,
      name: json['name'] as String,
      description: json['description'] as String?,
      directions: (json['itemListElement'] as List<dynamic>)
          .map((directionJson) => HowToDirection.fromJson(directionJson as JSONObject))
          .toList(),
      active: json['active'] as bool?,
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
      'active': active,
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

  /// Sets this step as active, which automatically sets all other steps as inactive.
  ///
  /// By setting the currently active step, the app is able to resume the user's progress in the project from where they
  /// left off. This is useful for when the user navigates away from the project and then returns to it later.
  Future<void> setActive({
    required User user,
    required String appCheckToken,
    required String projectId,
  }) async {
    // Get the use_emulator boolean from the `flutter run` command to determine if the Firebase Emulator Suite should
    // be used. The `fromEnvironment` method returns false by default if the argument is not passed.
    const bool useFirebaseEmulator = bool.fromEnvironment('USE_FIREBASE_EMULATOR');

    // Define the URL for the Firebase Functions endpoint, depending upon whether or not the Firebase Emulator Suite
    // should be used.
    const String functionUrl = useFirebaseEmulator
        ? 'http://$firebaseEmulatorsIp:5001/launchpad-d344d/us-central1/setCurrentStep'
        : 'https://us-central1-launchpad-d344d.cloudfunctions.net/setCurrentStep';

    // Get the user's ID token.
    final String? idToken = await user.getIdToken();
    if (idToken == null || idToken.isEmpty) {
      throw Exception('ID token is null');
    }

    // Send the POST request to the Firebase Functions endpoint. The project ID and step ID are included as
    // query parameters in the URL.
    final Response response;
    try {
      response = await post(
        Uri.parse('$functionUrl?projectId=$projectId&stepId=$id'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $idToken',
          'x-appcheck-token': appCheckToken,
        },
      );

      debugPrint('Successfully activated step, $id');
    } catch (e) {
      throw Exception('Failed to set active step with exception, $e');
    }

    // Check the response status code.
    if (response.statusCode != 200) {
      throw Exception('Failed to set active step with error message, ${response.body}');
    } else {
      debugPrint('Successfully set active step, $id');

      // Set the active field to true for the current step.
      active = true;
    }
  }
}
