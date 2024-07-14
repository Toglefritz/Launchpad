import 'package:firebase_vertexai/firebase_vertexai.dart';
import 'package:flutter/material.dart';
import 'package:launchpad_app/services/firebase_gemini/models/gemini_models.dart';
import 'package:launchpad_app/services/firebase_remote_config/remote_config_service.dart';
import 'package:launchpad_app/services/search/search_service.dart';

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

  /// Define configuration options for the Gemini model.
  ///
  /// The configuration options for the Gemini model instantiated by this services are stored in Firebase Remote
  /// Config.
  static final GenerationConfig _generationConfig = GenerationConfig(
    temperature: _remoteConfigService.getTemperature(),
  );

  /// Get a Gemini model to use for generative responses.
  ///
  /// Initialization of the model consists of selecting a model with system instructions and providing "tools" for
  /// function calling. The system instructions are fetched from Firebase Remote Config.
  static GenerativeModel get _model => FirebaseVertexAI.instance.generativeModel(
        model: GeminiModel.gemini15Flash.modelIdentifier,
        generationConfig: _generationConfig,
        systemInstruction: Content.system(_remoteConfigService.getSystemInstructions()),
        tools: [
          Tool(
            functionDeclarations: [
              SearchService.performSearchTool,
            ],
          ),
        ],
      );

  /// Starts a chat session with the Gemini [_model].
  ///
  /// A chat session is a multi-turn conversation with the Gemini model. This method starts a new chat session with the
  /// [_model] and returns the chat session object. This object handles management of the chat history internally.
  /// The [sendChatMessage] method is used to send messages from the user to the Gemini system to continue the chat
  /// session.
  static Future<ChatSession> startChat() async {
    try {
      final ChatSession chat = _model.startChat();

      return chat;
    } catch (e) {
      debugPrint('Starting chat with Gemini failed with exception, $e');
      // TODO(Toglefritz): How should this error be handled?

      rethrow;
    }
  }

  /// Uses the [_model] to generate a response to the prompt as part of a [ChatSession] ([chat]).
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

      debugPrint('Received response from Gemini');

      return response;
    } catch (e) {
      debugPrint('Receiving response from Gemini failed with exception, $e');

      rethrow;
    }
  }
}
