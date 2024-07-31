import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:launchpad_app/extensions/json_typedef.dart';
import 'package:launchpad_app/services/firebase_auth/models/profile_picture.dart';
import 'package:launchpad_app/services/firebase_core/firebase_emulators_ip.dart';

/// Represents information about the user that is not directly accessible from the Firebase Auth [User] object.
///
/// This application uses Firebase Auth for authentication. When a user creates an account, a file is created in the
/// Firestore database that stores additional information about the user. This class represents that information.
///
/// Additionally, this class is used to cache the user's profile information in memory to avoid asynchronous calls to
/// the Firestore database. These calls would create the need to handle loading times and potential errors. Getting
/// the user's profile information from memory is faster and more reliable.
class UserProfileService with ChangeNotifier {
  /// Field names in the Firestore document.
  static ValueNotifier<ProfilePicture> profilePictureNotifier = ValueNotifier<ProfilePicture>(
    ProfilePicture.profilePicture1,
  );

  /// Fetches the profile picture file name from Firestore and caches it in memory so it can be accessed quickly.
  static Future<void> fetchAndCacheProfilePicture({required User user, required String appCheckToken}) async {
    // Get the use_emulator boolean from the `flutter run` command to determine if the Firebase Emulator Suite should
    // be used. The `fromEnvironment` method returns false by default if the argument is not passed.
    const bool useFirebaseEmulator = bool.fromEnvironment('USE_FIREBASE_EMULATOR');

    // Define the URL for the Firebase Functions endpoint, depending upon whether or not the Firebase Emulator Suite
    // should be used.
    const String functionUrl = useFirebaseEmulator
        ? 'http://$firebaseEmulatorsIp:5001/launchpad-d344d/us-central1/getProfilePicture'
        : 'https://us-central1-launchpad-d344d.cloudfunctions.net/getProfilePicture';

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

      debugPrint('Successfully retrieved profile picture');
    } catch (e) {
      throw Exception('Failed to retrieve profile picture with exception, $e');
    }

    // Check the response status code.
    if (response.statusCode != 200) {
      throw Exception('Failed to update project with error message, ${response.body}');
    } else {
      // Parse the response body.
      final JSONObject responseBody = jsonDecode(response.body) as JSONObject;
      final String? picture = responseBody['profilePicture'] as String?;

      // Cache the profile picture URL.
      if (picture != null) {
        profilePictureNotifier.value = ProfilePicture.values.firstWhere(
          (ProfilePicture element) => element.fileName == picture,
        );
        profilePictureNotifier.notifyListeners();
      }
    }
  }

  /// Sets the profile picture to the given [ProfilePicture] value. The new profile picture file name is set in the
  /// user's file in the Firestore database.
  static Future<void> setProfilePicture({
    required ProfilePicture newPicture,
    required User user,
    required String appCheckToken,
  }) async {
    // Get the use_emulator boolean from the `flutter run` command to determine if the Firebase Emulator Suite should
    // be used. The `fromEnvironment` method returns false by default if the argument is not passed.
    const bool useFirebaseEmulator = bool.fromEnvironment('USE_FIREBASE_EMULATOR');

    // Define the URL for the Firebase Functions endpoint, depending upon whether or not the Firebase Emulator Suite
    // should be used.
    const String functionUrl = useFirebaseEmulator
        ? 'http://$firebaseEmulatorsIp:5001/launchpad-d344d/us-central1/setProfilePicture'
        : 'https://us-central1-launchpad-d344d.cloudfunctions.net/setProfilePicture';

    // Get the user's ID token.
    final String? idToken = await user.getIdToken();
    if (idToken == null || idToken.isEmpty) {
      throw Exception('ID token is null');
    }

    // Assemble the request body.
    final JSONObject requestBody = <String, String>{
      'profilePicture': newPicture.fileName,
    };

    // Send the PATCH request to the Firebase Functions endpoint.
    final Response response;
    try {
      response = await patch(
        Uri.parse('$functionUrl?userId=${user.uid}'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $idToken',
          'x-appcheck-token': appCheckToken,
        },
        body: jsonEncode(requestBody),
      );

      debugPrint('Successfully set profile picture');
    } catch (e) {
      throw Exception('Failed to set profile picture with exception, $e');
    }

    // Check the response status code.
    if (response.statusCode != 200) {
      debugPrint('Failed to update project with error message, ${response.body}');

      throw Exception('Failed to update project with error message, ${response.body}');
    } else {
      // Cache the profile picture URL.
      profilePictureNotifier.value = newPicture;
      profilePictureNotifier.notifyListeners();
    }
  }
}
