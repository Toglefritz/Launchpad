import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart';
import 'package:launchpad_app/extensions/json_typedef.dart';
import 'package:launchpad_app/services/firebase_core/firebase_emulators_ip.dart';
import 'package:launchpad_app/services/project/augmented_project.dart';

/// [ProjectService] handles the network requests use for CRUD operations on projects via Firebase Functions.
///
/// The Firebase backend for the Launchpad app uses Firebase Functions to handle the creation, reading, updating, and
/// deletion of projects. Project information is stored in a Firestore database where each project created by any
/// user is represented by a document containing the project data. Each project document also contains a unique
/// identifier that is used to reference the project in the database.
///
/// For example,
/// ```json
/// {
///   "projectId": "abc123",
///   "projectData": {
///     <project JSON object>
///   }
/// }
/// ```
///
/// Each user has a file in a different Firestore collection that contains, among other information, a list of
/// project IDs that the user has created. This list is used to retrieve the projects that the user has created.
/// The unique identifier of the project is used to reference the project in the user's file.
class ProjectService {
  /// The Firebase Auth [User] object representing the current user.
  final User user;

  /// Creates a [ProjectService] with the provided [User].
  const ProjectService(this.user);

  /// Creates a project by sending a POST request to the `createProject` endpoint of the Firebase Functions.
  ///
  /// A successful call to this endpoint will perform two operations:
  ///   1. Create a new project document in the Firestore database with the provided project data.
  ///   2. Add the unique identifier of the newly created project to the list of project IDs in the user's file.
  ///
  /// The endpoint will return a status code of 201 if the project is created successfully.
  Future<void> createProject(AugmentedProject augmentedProject) async {
    // Get the use_emulator boolean from the `flutter run` command to determine if the Firebase Emulator Suite should
    // be used. The `fromEnvironment` method returns false by default if the argument is not passed.
    const bool useFirebaseEmulator = bool.fromEnvironment('USE_FIREBASE_EMULATOR');

    // Define the URL for the Firebase Functions endpoint, depending upon whether or not the Firebase Emulator Suite
    // should be used.
    const String functionUrl = useFirebaseEmulator
        ? 'http://$firebaseEmulatorsIp:5001/launchpad-d344d/us-central1/createProject'
        : 'https://us-central1-launchpad-d344d.cloudfunctions.net/createProject';

    // Build the body of the request.
    final JSONObject requestBody = {
      'userId': user.uid,
      'projectData': augmentedProject.toJson(),
    };

    // Send the POST request to the Firebase Functions endpoint.
    final Response response;
    try {
      response = await post(
        Uri.parse(functionUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(requestBody),
      );
    } catch (e) {
      throw Exception('Failed to create project with exception, $e');
    }

    // Check the response status code.
    if (response.statusCode != 201) {
      throw Exception('Failed to create project with error message, ${response.body}');
    }
  }

  /// Retrieves an individual project by sending a GET request to the `readProject` endpoint of the Firebase Functions.
  ///
  /// This endpoint is provided with the unique identifier of the project to be retrieved. The endpoint will return the
  /// project data as an instance of [AugmentedProject] if the request is successful.
  ///
  /// The endpoint will return a 200 status code if the project data is retrieved successfully, along with the project
  /// data in the response body.
  Future<AugmentedProject> readProject(String projectId) async {
    // Get the use_emulator boolean from the `flutter run` command to determine if the Firebase Emulator Suite should
    // be used. The `fromEnvironment` method returns false by default if the argument is not passed.
    const bool useFirebaseEmulator = bool.fromEnvironment('USE_FIREBASE_EMULATOR');

    // Define the URL for the Firebase Functions endpoint, depending upon whether or not the Firebase Emulator Suite
    // should be used.
    const String functionUrl = useFirebaseEmulator
        ? 'http://$firebaseEmulatorsIp:5001/launchpad-d344d/us-central1/readProject'
        : 'https://us-central1-launchpad-d344d.cloudfunctions.net/readProject';

    // Send the GET request to the Firebase Functions endpoint. The project ID is included as a query parameter.
    final Response response;
    try {
      response = await get(
        Uri.parse('$functionUrl?projectId=$projectId'),
        headers: {
          'Content-Type': 'application/json',
        },
      );
    } catch (e) {
      throw Exception('Failed to read project with exception, $e');
    }

    // Check the response status code.
    if (response.statusCode != 200) {
      throw Exception('Failed to read project with error message, ${response.body}');
    }

    // Parse the response JSON from the response body.
    final JSONObject responseJson = jsonDecode(response.body) as JSONObject;

    // Construct an AugmentedProject object from the response data.
    return AugmentedProject.fromJson(responseJson);
  }

  /// Updates a project by sending a POST request to the `updateProject` endpoint of the Firebase Functions.
  ///
  /// The endpoint is provided with the unique identifier of the project to be updated and the updated project data. The
  /// updated data will contain only the fields that should be changed. Any fields that are not included in the
  /// request body will remain unchanged.
  ///
  /// The endpoint will return a 200 status code if the project data in the Firestore backend is updated successfully.
  Future<void> updateProject(String projectId, AugmentedProject updatedProject) async {
    // Get the use_emulator boolean from the `flutter run` command to determine if the Firebase Emulator Suite should
    // be used. The `fromEnvironment` method returns false by default if the argument is not passed.
    const bool useFirebaseEmulator = bool.fromEnvironment('USE_FIREBASE_EMULATOR');

    // Define the URL for the Firebase Functions endpoint, depending upon whether or not the Firebase Emulator Suite
    // should be used.
    const String functionUrl = useFirebaseEmulator
        ? 'http://$firebaseEmulatorsIp:5001/launchpad-d344d/us-central1/updateProject'
        : 'https://us-central1-launchpad-d344d.cloudfunctions.net/updateProject';

    // Build the body of the request.
    final JSONObject requestBody = {
      'projectData': updatedProject.toJson(),
    };

    // Send the POST request to the Firebase Functions endpoint.
    final Response response;
    try {
      response = await post(
        Uri.parse('$functionUrl?projectId=$projectId'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(requestBody),
      );
    } catch (e) {
      throw Exception('Failed to update project with exception, $e');
    }

    // Check the response status code.
    if (response.statusCode != 200) {
      throw Exception('Failed to update project with error message, ${response.body}');
    }
  }

  /// Deletes a project by sending a DELETE request to the `deleteProject` endpoint of the Firebase Functions.
  ///
  /// The endpoint is provided with the unique identifier of the project to be deleted. A successful call to this
  /// endpoint will result in the deletion of the project document from the Firestore database and the removal of the
  /// project ID from the list of project IDs in the user's file.
  ///
  /// The endpoint will return a 200 status code if the project is deleted successfully.
  Future<void> deleteProject(String projectId) async {
    // Get the use_emulator boolean from the `flutter run` command to determine if the Firebase Emulator Suite should
    // be used. The `fromEnvironment` method returns false by default if the argument is not passed.
    const bool useFirebaseEmulator = bool.fromEnvironment('USE_FIREBASE_EMULATOR');

    // Define the URL for the Firebase Functions endpoint, depending upon whether or not the Firebase Emulator Suite
    // should be used.
    const String functionUrl = useFirebaseEmulator
        ? 'http://$firebaseEmulatorsIp:5001/launchpad-d344d/us-central1/deleteProject'
        : 'https://us-central1-launchpad-d344d.cloudfunctions.net/deleteProject';

    // Build the body of the request.
    final JSONObject requestBody = {
      'userId': user.uid,
    };

    // Send the DELETE request to the Firebase Functions endpoint. The project ID is included as a query parameter.
    final Response response;
    try {
      response = await delete(
        Uri.parse('$functionUrl?projectId=$projectId'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(requestBody),
      );
    } catch (e) {
      throw Exception('Failed to delete project with exception, $e');
    }

    // Check the response status code.
    if (response.statusCode != 200) {
      throw Exception('Failed to delete project with error message, ${response.body}');
    }
  }
}
