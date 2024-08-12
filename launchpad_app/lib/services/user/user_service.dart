import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:launchpad_app/extensions/json_typedef.dart';
import 'package:launchpad_app/services/firebase_core/firebase_emulators_ip.dart';
import 'package:launchpad_app/services/project/models/earned_achievement.dart';

/// [UserService] handles the network requests related to information about the current user, represented in the
/// contents of a Firestore document for the user.
class UserService {
  /// The Firebase Auth [User] object representing the current user.
  final User user;

  /// Creates a [UserService] with the provided [User].
  const UserService(this.user);

  /// Gets a list of current projects for the user.
  ///
  /// Each user in the Launchpad app has a file in a Firestore backend that contains, among other information, a list
  /// of projects that the user has created. This list consists of a series of project IDs. This function retrieves the
  /// list of projects for the current user and returns the list.
  ///
  /// When a use is created, a Firebase Functions trigger is responsible to creating the Firestore document for that
  /// user. Because that process is not instantaneous, the user may not have a Firestore document immediately after
  /// account creation. Therefore, this function implements a retry mechanism to catch 404 responses resulting from
  /// attempting to read a user's projects before the Firestore document has been created.
  Future<List<String>> getCurrentProjects({required String appCheckToken}) async {
    // Get the use_emulator boolean from the `flutter run` command to determine if the Firebase Emulator Suite should
    // be used. The `fromEnvironment` method returns false by default if the argument is not passed.
    const bool useFirebaseEmulator = bool.fromEnvironment('USE_FIREBASE_EMULATOR');

    // Define the URL for the Firebase Functions endpoint, depending upon whether or not the Firebase Emulator Suite
    // should be used.
    const String functionUrl = useFirebaseEmulator
        ? 'http://$firebaseEmulatorsIp:5001/launchpad-d344d/us-central1/getCurrentProjects'
        : 'https://us-central1-launchpad-d344d.cloudfunctions.net/getCurrentProjects';

    // The maximum number of retries to attempt when fetching the user's projects.
    const int maxRetries = 3;

    // The interval between retries.
    const Duration retryInterval = Duration(seconds: 1);

    // Get the user's ID token.
    final String? idToken = await user.getIdToken();
    if (idToken == null || idToken.isEmpty) {
      throw Exception('ID token is null');
    }

    // Send the GET request to the Firebase Functions endpoint.
    final Response response;
    try {
      response = await get(
        Uri.parse('$functionUrl?userId=${user.uid}'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $idToken',
          'x-appcheck-token': appCheckToken,
        },
      );
    } catch (e) {
      debugPrint('Failed to get current projects with exception, $e');

      throw Exception('Failed to read project with exception, $e');
    }

    // A 204 status code indicates that the user has no projects.
    if (response.statusCode == 204 || response.body.isEmpty) {
      debugPrint('User has no projects');

      return [];
    }
    // A 200 status code indicates that the user has projects.
    else if (response.statusCode == 200) {
      // Get a list of project IDs from the response.
      final JSONArray responseBody = jsonDecode(response.body) as JSONArray;

      // Convert the JSON array to a list of strings.
      final List<String> projectIds = responseBody.map((dynamic id) => id as String).toList();

      return projectIds;
    }
    // If the status code is 404, it is possible that the Firestore document for the user has not been created yet.
    // Therefore, retry the request a few times before giving up.
    else if (response.statusCode == 404) {
      debugPrint('User document not found yet, retrying');

      for (int i = 0; i < maxRetries; i++) {
        await Future<void>.delayed(retryInterval);

        try {
          final Response retryResponse = await get(
            Uri.parse('$functionUrl?userId=${user.uid}'),
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $idToken',
              'x-appcheck-token': appCheckToken,
            },
          );

          if (retryResponse.statusCode == 200) {
            final JSONArray responseBody = jsonDecode(retryResponse.body) as JSONArray;

            final List<String> projectIds = responseBody.map((dynamic id) => id as String).toList();

            return projectIds;
          } else if (retryResponse.statusCode == 204) {
            debugPrint('User has no projects');

            return [];
          }
        } catch (e) {
          debugPrint('Failed to get current projects with exception, $e');
        }
      }

      throw Exception('Failed to read projects after retries with status code, ${response.statusCode}');
    }
    // Any other status code indicates an error.
    else {
      debugPrint(
        'Failed to read project with status code, ${response.statusCode}, and error message, ${response.body}',
      );

      throw Exception('Failed to read project with status code, ${response.statusCode}');
    }
  }

  /// Gets a list of achievements the user has earned.
  ///
  /// Each user in the Launchpad app has a file in a Firestore backend that contains, among other information, a list
  /// of achievements that the user has earned. This list consists of a series of JSON objects containing information
  /// about the achievements the user has earned. Each achievement has a name, description, and the timestamp at which
  /// the achievement was earned. This function retrieves the list of achievements for the current user and returns the
  /// list.
  ///
  /// If the user has no achievements, the function returns an empty list.
  ///
  /// When a use is created, a Firebase Functions trigger is responsible to creating the Firestore document for that
  /// user. Because that process is not instantaneous, the user may not have a Firestore document immediately after
  /// account creation. Therefore, this function implements a retry mechanism to catch 404 responses resulting from
  /// attempting to read a user's achievements before the Firestore document has been created.
  Future<List<EarnedAchievement>> getEarnedAchievements({required String appCheckToken}) async {
    // Get the use_emulator boolean from the `flutter run` command to determine if the Firebase Emulator Suite should
    // be used. The `fromEnvironment` method returns false by default if the argument is not passed.
    const bool useFirebaseEmulator = bool.fromEnvironment('USE_FIREBASE_EMULATOR');

    // Define the URL for the Firebase Functions endpoint, depending upon whether or not the Firebase Emulator Suite
    // should be used.
    const String functionUrl = useFirebaseEmulator
        ? 'http://$firebaseEmulatorsIp:5001/launchpad-d344d/us-central1/getAchievements'
        : 'https://us-central1-launchpad-d344d.cloudfunctions.net/getAchievements';

    // The maximum number of retries to attempt when fetching the user's projects.
    const int maxRetries = 3;

    // The interval between retries.
    const Duration retryInterval = Duration(seconds: 1);

    // Get the user's ID token.
    final String? idToken = await user.getIdToken();
    if (idToken == null || idToken.isEmpty) {
      throw Exception('ID token is null');
    }

    // Send the GET request to the Firebase Functions endpoint.
    final Response response;
    try {
      response = await get(
        Uri.parse('$functionUrl?userId=${user.uid}'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $idToken',
          'x-appcheck-token': appCheckToken,
        },
      );
    } catch (e) {
      debugPrint('Failed to get current projects with exception, $e');

      throw Exception('Failed to read project with exception, $e');
    }

    // A 200 status code indicates that the user has achievements and that they were successfully retrieved.
    if (response.statusCode == 200) {
      // Get a list of achievements from the response.
      final JSONArray responseBody = jsonDecode(response.body) as JSONArray;

      // Convert the JSON array to a list of [EarnedAchievement] objects.
      final List<EarnedAchievement> achievements = responseBody.map((dynamic achievement) {
        final JSONObject achievementMap = achievement as JSONObject;

        return EarnedAchievement.fromJson(achievementMap);
      }).toList();

      return achievements;
    }
    // A 204 status code indicates that the request was successful, but the user has no achievements.
    else if (response.statusCode == 204) {
      debugPrint('User has no achievements');

      return [];
    }
    // If the status code is 404, it is possible that the Firestore document for the user has not been created yet.
    // Therefore, retry the request a few times before giving up.
    else if (response.statusCode == 404) {
      debugPrint('User document not found yet, retrying');

      for (int i = 0; i < maxRetries; i++) {
        await Future<void>.delayed(retryInterval);

        try {
          final Response retryResponse = await get(
            Uri.parse('$functionUrl?userId=${user.uid}'),
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $idToken',
              'x-appcheck-token': appCheckToken,
            },
          );

          if (retryResponse.statusCode == 200) {
            final JSONArray responseBody = jsonDecode(retryResponse.body) as JSONArray;

            final List<EarnedAchievement> achievements = responseBody.map((dynamic achievement) {
              final JSONObject achievementMap = achievement as JSONObject;

              return EarnedAchievement.fromJson(achievementMap);
            }).toList();

            return achievements;
          } else if (retryResponse.statusCode == 204) {
            debugPrint('User has no achievements');

            return [];
          }
        } catch (e) {
          debugPrint('Failed to get current projects with exception, $e');
        }
      }

      throw Exception('Failed to read achievements after retries with status code, ${response.statusCode}');
    }
    // Any other status code indicates an error.
    else {
      debugPrint(
        'Failed to read achievements with status code, ${response.statusCode}, and error message, ${response.body}',
      );

      throw Exception('Failed to read achievements with status code, ${response.statusCode}');
    }
  }
}
