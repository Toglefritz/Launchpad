import 'package:firebase_vertexai/firebase_vertexai.dart';
import 'package:flutter/material.dart';
import 'package:gadgetron_app/services/firebase_gemini/models/gemini_models.dart';
import 'package:gadgetron_app/services/firebase_remote_config/remote_config_service.dart';

/// This service provides methods for interacting with Google Gemini AI systems, mainly providing prompts to Gemini
/// models and receiving responses.
///
/// The core features offered by the Gadgetron app are powered by Google's Gemini family of AI models. These models are
/// multimodal, meaning they can process information from multiple modalities, including images, videos, and text. This
/// is important for the Gadgetron app which offers features that interact with the Gemini models in different ways
/// using different inputs.
///
/// This service provides a single point of access to the Gemini models used by the Gadgetron app.
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
  /// Initialization of the model consists of selecting a model and providing system instructions. The latter is fetched
  /// from Firebase Remote Config.
  static GenerativeModel get _model => FirebaseVertexAI.instance.generativeModel(
        model: GeminiModel.gemini15Flash.modelIdentifier,
        generationConfig: _generationConfig,
        systemInstruction: Content.system(_remoteConfigService.getSystemInstructions()),
      );

  /// Uses the [_model] to generate a response to the [prompt].
  ///
  /// The [prompt] is a list of [Content] objects that represent the user's input to the Gemini model. The Gemini model
  /// is pre-configured with a system instruction and a temperature parameter. This method submits the [prompt] to the
  /// model and returns the response.
  static Future<GenerateContentResponse?> getResponse(String prompt) async {
    // Convert the provided string to a list of Content objects.
    final List<Content> promptContent = [Content.text(prompt)];

    try {
      final GenerateContentResponse response = await _model.generateContent(promptContent);

      debugPrint('Received response from Gemini');

      return response;
    } catch (e) {
      debugPrint('Receiving response from Gemini failed with exception, $e');

      rethrow;
    }
  }
}
