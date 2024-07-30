import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:launchpad_app/extensions/json_typedef.dart';
import 'package:launchpad_app/services/firebase_core/firebase_emulators_ip.dart';
import 'package:launchpad_app/services/uuid/uuid_generator.dart';

/// Represents a direction in the HowTo schema.
class HowToDirection {
  /// A unique identifier for the direction.
  final String id;

  /// The detailed instructions for the direction.
  final String text;

  /// Determines if the direction has been completed.
  bool isComplete;

  /// Creates an instance of [HowToDirection].
  HowToDirection._({
    required this.id,
    required this.text,
    required this.isComplete,
  });

  /// Creates an instance of [HowToDirection] from a JSON object.
  factory HowToDirection.fromJson(Map<String, dynamic> json) {
    // Generate a unique identifier for the direction, which is a random UUID.
    final String id = json['id'] as String? ?? UuidGenerator.generateUuid();

    return HowToDirection._(
      id: id,
      text: json['text'] as String,
      isComplete: json['complete'] as bool? ?? false,
    );
  }

  /// Converts the direction to a JSON object.
  JSONObject toJson() {
    return {
      'id': id,
      'text': text,
      'complete': isComplete,
    };
  }

  /// Calls a Firebase Function endpoint to mark the direction as complete in the Firestore database.
  ///
  /// The [projectId] parameter is the unique identifier for the project to which the direction belongs. The method
  /// sends a PATCH request to the Firebase Functions endpoint to update the direction's `complete` field in the
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
        ? 'http://$firebaseEmulatorsIp:5001/launchpad-d344d/us-central1/toggleDirectionComplete'
        : 'https://us-central1-launchpad-d344d.cloudfunctions.net/toggleDirectionComplete';

    // Get the user's ID token.
    final String? idToken = await user.getIdToken();
    if (idToken == null || idToken.isEmpty) {
      throw Exception('ID token is null');
    }

    // Send the PATCH request to the Firebase Functions endpoint. The project ID and direction ID are included as
    // query parameters in the URL.
    final Response response;
    try {
      response = await patch(
        Uri.parse('$functionUrl?projectId=$projectId&directionId=$id'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $idToken',
          'x-appcheck-token': appCheckToken,
        },
      );

      debugPrint('Successfully toggled direction completion');
    } catch (e) {
      throw Exception('Failed to toggle direction completion with exception, $e');
    }

    // Check the response status code.
    if (response.statusCode != 200) {
      throw Exception('Failed to toggle direction completion with error message, ${response.body}');
    } else {
      // Update the direction's `isComplete` property if the request was successful.
      final JSONObject json = jsonDecode(response.body) as JSONObject;
      isComplete = json['complete'] as bool;
    }
  }
}
