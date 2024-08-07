import 'dart:convert';

import 'package:firebase_vertexai/firebase_vertexai.dart';
import 'package:flutter/material.dart';
import 'package:launchpad_app/extensions/json_typedef.dart';
import 'package:launchpad_app/services/firebase_gemini/models/gemini_models.dart';
import 'package:launchpad_app/services/firebase_remote_config/remote_config_service.dart';
import 'package:launchpad_app/services/project/models/achievement.dart';
import 'package:launchpad_app/services/project/models/how_to_step.dart';

/// This service provides methods for interacting with Google Gemini AI systems, mainly providing prompts to Gemini
/// models and receiving responses.
///
/// The core features offered by the Launchpad app are powered by Google's Gemini family of AI models. These models are
/// multimodal, meaning they can process information from multiple modalities, including images, videos, and text. This
/// is important for the Launchpad app which offers features that interact with the Gemini models in different ways
/// using different inputs.
///
/// This service provides a single point of access to the Gemini models used by the Launchpad app.
class GeminiService {
  /// Some configuration options and parts of the app's prompting strategy are stored in Firebase Remote Config. Using
  /// Remote Config allows the app to dynamically update these values without requiring a new app release. This service
  /// is used to fetch these values.
  static final RemoteConfigService _remoteConfigService = RemoteConfigService();

  /// Define configuration options for the Gemini model used for project creation.
  ///
  /// The configuration options for the Gemini model instantiated by this services are stored in Firebase Remote
  /// Config.
  static final GenerationConfig _projectCreationGenerationConfig = GenerationConfig(
    temperature: _remoteConfigService.getProjectCreationTemperature(),
  );

  /// Define configuration options for the Gemini model used for project exploration.
  ///
  /// The configuration options for the Gemini model instantiated by this services are stored in Firebase Remote
  /// Config.
  static final GenerationConfig _projectExploreGenerationConfig = GenerationConfig(
    temperature: _remoteConfigService.getProjectExploreTemperature(),
  );

  /// Get a Gemini model to use for generative responses used when creating a project.
  ///
  /// Initialization of the model consists of selecting a model with system instructions. The system instructions are
  /// fetched from Firebase Remote Config.
  // TODO(Toglefritz): specify MIME type as JSON when the feature is supported
  static GenerativeModel get _projectCreationModel => FirebaseVertexAI.instance.generativeModel(
        model: GeminiModel.gemini15Flash.modelIdentifier,
        generationConfig: _projectCreationGenerationConfig,
        systemInstruction: Content.system(_remoteConfigService.getProjectCreationSystemInstructions()),
      );

  /// Get a Gemini model to use for generative responses to user queries about a project.
  ///
  /// The chat model is initialized with a system instruction that is fetched from Firebase Remote Config. These system
  /// instructions act as a preamble to the chat session and provide context for the user. A JSON object describing the
  /// project is appended to the system instructions to provide the Gemini model with context about the project.
  static GenerativeModel _getProjectChatModel(JSONObject project) {
    // Get the initial part of the system instructions from Firebase Remote Config.
    final String systemInstructionsPreamble = _remoteConfigService.getProjectChatSystemInstructions();

    // Append a String representation of the project data to the system instructions.
    final String systemInstructions = '$systemInstructionsPreamble \'\'\'json $project\'\'\'';

    return FirebaseVertexAI.instance.generativeModel(
      model: GeminiModel.gemini15Flash.modelIdentifier,
      generationConfig: _projectExploreGenerationConfig,
      systemInstruction: Content.system(systemInstructions),
    );
  }

  /// Get a Gemini model to use for building achievements for a project.
  ///
  /// Projects in the Launchpad app can have achievements that are generated using a Gemini model. This method returns
  /// a Gemini model that is configured to generate achievements for a project.
  // TODO(Toglefritz): specify MIME type as JSON when the feature is supported
  static GenerativeModel get _achievementModel => FirebaseVertexAI.instance.generativeModel(
        model: GeminiModel.gemini15Flash.modelIdentifier,
        generationConfig: _projectCreationGenerationConfig,
      );

  /// Starts a chat session with the Gemini [_projectCreationModel].
  ///
  /// A chat session is a multi-turn conversation with the Gemini model. This method starts a new chat session with the
  /// [_projectCreationModel] and returns the chat session object. This object handles management of the chat history
  /// internally. The [sendChatMessage] method is used to send messages from the user to the Gemini system to continue
  /// the chat session.
  static Future<ChatSession> startProjectCreationChat() async {
    try {
      final ChatSession chat = _projectCreationModel.startChat();

      return chat;
    } catch (e) {
      debugPrint('Starting chat with Gemini failed with exception, $e');
      // TODO(Toglefritz): How should this error be handled?

      rethrow;
    }
  }

  /// Starts a chat session with the Gemini model for a project query.
  ///
  /// A chat session is a multi-turn conversation with the Gemini model. This method starts a new chat session with the
  /// Gemini model and returns the chat session object.
  static Future<ChatSession> startProjectQueryChat(JSONObject project) async {
    try {
      final ChatSession chat = _getProjectChatModel(project).startChat();

      return chat;
    } catch (e) {
      debugPrint('Starting chat with Gemini failed with exception, $e');

      rethrow;
    }
  }

  /// Uses the provided [ChatSession] to generate a response to the prompt as part of a [ChatSession] ([chat]).
  ///
  /// The [content] argument can take several forms. The most common is a query from the user, as a string, or the
  /// results from function calls invoked from responses received from the model. The Gemini model is pre-configured
  /// with a system instruction and a temperature parameter. This method submits the [content] to the model as part of
  /// the provided [ChatSession] and returns the response.
  ///
  /// This method does not stream responses from Gemini. Instead, the method waits for the response to be generated and
  /// returned in full before returning the response.
  static Future<GenerateContentResponse> sendChatMessage({
    required ChatSession chat,
    required Content content,
  }) async {
    try {
      final GenerateContentResponse response = await chat.sendMessage(content);

      debugPrint('Received chat message from Gemini');

      return response;
    } catch (e) {
      debugPrint('Receiving chat message from Gemini failed with exception, $e');

      rethrow;
    }
  }

  /// Uses the [_achievementModel] to generate an achievement for a project.
  ///
  /// This function accepts a list of project steps that the Gemini model will use to generate an achievement. This
  /// function starts by constructing a prompt for the Gemini model using two pieces of information: the preamble for
  /// the prompt, which is fetched from Firebase Remote Config, and the list of project steps. The project steps are
  /// serialized as a JSON array and appended to the preamble.
  ///
  /// The prompt is then sent to the Gemini model, which generates a response containing a list of achievements. The
  /// response is parsed and converted into a list of [Achievement] objects, which are then returned.
  static Future<List<Achievement>> generateAchievements({
    required List<HowToStep> steps,
  }) async {
    // Get the preamble for the achievement prompt.
    final String promptPreamble = _remoteConfigService.getAchievementPromptPreamble();

    // Add the list of project steps to the content as a serialized JSON array.
    final List<Map<String, dynamic>> stepsJson = steps.map((HowToStep step) => step.toJson()).toList();

    // Build the content object to send to the Gemini model.
    final Content content = Content.text(
      '$promptPreamble $stepsJson',
    );

    try {
      final GenerateContentResponse response = await _achievementModel.generateContent([content]);

      debugPrint('Received achievement from Gemini: ${response.text}');

      // Convert the response to a list of achievements.
      final String? responseText = response.text;
      // Get the JSON content itself from the response, by extracting the substring between the first and last square
      // brackets.
      final String? jsonContent = responseText?.substring(responseText.indexOf('['), responseText.lastIndexOf(']') + 1);

      if (jsonContent == null) {
        throw Exception('Received null response from Gemini');
      }

      // Remove all newlines from the JSON content.
      jsonContent.replaceAll('\n', '');

      // Parse the JSON response from the Gemini model.
      final JSONArray responseJson = json.decode(jsonContent) as JSONArray;

      // Convert the JSON response to a list of achievements.
      final List<Achievement> achievements =
          responseJson.map((item) => Achievement.fromJson(item as JSONObject)).toList();

      return achievements;
    } catch (e) {
      debugPrint('Receiving achievement from Gemini failed with exception, $e');

      rethrow;
    }
  }
}
