import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:launchpad_app/extensions/json_typedef.dart';
import 'package:launchpad_app/services/firebase_core/firebase_emulators_ip.dart';

/// Represents an achievement for a project.
///
/// Achievements are awarded to users when they complete certain steps in a project. Each achievement has a title and a
/// description. The title is a short, descriptive name for the achievement, while the description provides more
/// information about the achievement and the step that must be completed to unlock it. Additionally, each achievement
/// has a step ID that corresponds to the ID of the step that must be completed to unlock the achievement.
class Achievement {
  /// The unique ID of the step that must be completed to unlock the achievement.
  final String id;

  /// The name of the achievement.
  final String title;

  /// A description of the achievement.
  final String description;

  /// Determines if the achievement has been completed.
  bool isComplete;

  /// Creates an [Achievement] object.
  Achievement({
    required this.id,
    required this.title,
    required this.description,
    this.isComplete = false,
  });

  /// Creates an [Achievement] object from a JSON object.
  factory Achievement.fromJson(JSONObject json) {
    return Achievement(
      id: json['id'] as String,
      title: json['name'] as String,
      description: json['description'] as String,
      isComplete: json['complete'] as bool? ?? false,
    );
  }

  /// Converts the achievement to a JSON object.
  JSONObject toJson() {
    return <String, dynamic>{
      'id': id,
      'name': title,
      'description': description,
      'complete': false,
    };
  }

  /// Calls a Firebase Function endpoint to mark this achievement as complete in the Firestore database.
  ///
  /// The [projectId] parameter is the unique identifier for the project to which the achievement belongs. The method
  /// sends a PATCH request to the Firebase Functions endpoint to update the achievement's `complete` field in the
  /// Firestore database.
  Future<void> markAsComplete({
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
        ? 'http://$firebaseEmulatorsIp:5001/launchpad-d344d/us-central1/toggleAchievementComplete'
        : 'https://us-central1-launchpad-d344d.cloudfunctions.net/toggleAchievementComplete';

    // Get the user's ID token.
    final String? idToken = await user.getIdToken();
    if (idToken == null || idToken.isEmpty) {
      throw Exception('ID token is null');
    }

    // Send the PATCH request to the Firebase Functions endpoint. The project ID and achievement ID are included as
    // query parameters in the URL.
    final Response response;
    try {
      response = await patch(
        Uri.parse('$functionUrl?userId=${user.uid}&projectId=$projectId&achievementId=$id'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $idToken',
          'x-appcheck-token': appCheckToken,
        },
      );

      debugPrint('Successfully toggled achievement completion');
    } catch (e) {
      throw Exception('Failed to toggle achievement completion with exception, $e');
    }

    // Check the response status code.
    if (response.statusCode != 200) {
      throw Exception('Failed to toggle achievement completion with error message, ${response.body}');
    } else {
      // Update the achievement's `isComplete` property if the request was successful.
      final JSONObject json = jsonDecode(response.body) as JSONObject;
      isComplete = json['complete'] as bool;
    }
  }
}
