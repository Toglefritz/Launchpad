import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart';
import 'package:launchpad_app/extensions/json_typedef.dart';
import 'package:launchpad_app/services/firebase_core/firebase_emulators_ip.dart';
import 'package:launchpad_app/services/image_generation/models/generated_image.dart';
import 'package:launchpad_app/services/project/project.dart';

/// [ImageGenerationService] handles the network requests to the image generation endpoint via Firebase Functions.
///
/// This service is used to generate image for learning projects and/or individual project steps. These images are
/// used purely for decorative purposes and are not intended to be instructive in themselves.
///
/// The image generation service sends a POST request to the `generateImage` endpoint of the Firebase Functions,
/// including the provided prompt and authentication token in the request. It returns the generated image data as a map
/// if the request is successful. Assuming the request is successful, the app will construct a [GeneratedImage] object
/// from the response data.
class ImageGenerationService {
  /// Generates an image based on the provided prompt by calling the `generateImage` endpoint of the Firebase Functions.
  ///
  /// This function sends a POST request to the `generateImage` endpoint, including the provided prompt and
  /// authentication token in the request. It returns the generated image data as a map if the request is successful.
  /// Assuming the request is successful, the app will construct a [GeneratedImage] object from the response data.
  ///
  /// Returns a [Future] that resolves to a [GeneratedImage] containing the generated image information.
  ///
  /// Throws an [Exception] if the request fails with an error message.
  static Future<GeneratedImage> generateImage({
    required User user,
    required String appCheckToken,
    required String prompt,
  }) async {
    // Get the use_emulator boolean from the `flutter run` command to determine if the Firebase Emulator Suite should
    // be used. The `fromEnvironment` method returns false by default if the argument is not passed.
    const bool useFirebaseEmulator = bool.fromEnvironment('USE_FIREBASE_EMULATOR');

    // Define the URL for the Firebase Functions endpoint, depending upon whether or not the Firebase Emulator Suite
    // should be used.
    const String functionUrl = useFirebaseEmulator
        ? 'http://$firebaseEmulatorsIp:5001/launchpad-d344d/us-central1/generateImage'
        : 'https://us-central1-launchpad-d344d.cloudfunctions.net/generateImage';

    // Get the user's ID token.
    final String? idToken = await user.getIdToken();
    if (idToken == null || idToken.isEmpty) {
      throw Exception('ID token is null');
    }

    final Response response;
    try {
      response = await post(
        Uri.parse(functionUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $idToken',
          'x-appcheck-token': appCheckToken,
        },
        body: jsonEncode({
          'prompt': prompt,
        }),
      );
    } catch (e) {
      throw Exception('Image generation failed with exception, $e');
    }

    // A 200 status means the image was generated successfully.
    if (response.statusCode == 200) {
      // Parse the response JSON from the response body.
      final JSONObject responseJson = jsonDecode(response.body) as JSONObject;

      // Construct a GeneratedImage object from the response data.
      return GeneratedImage.fromJson(responseJson);
    } else {
      throw Exception('Failed to generate image with error message ${response.body}');
    }
  }

  /// Builds a prompt for the image generation service based on the project contents.
  ///
  /// This function accepts a [Project] object and returns a string prompt that can be used to generate an image for the
  /// project. The prompt is constructed from the JSON representation of the project, along with additional instructions
  /// to the image generation model.
  static String buildPromptFromProject(Project project) {
    final String prompt =
        'Create a cover image for a project titled "${project.name}," with the description, "${project.description}."';

    return prompt;
  }
}
