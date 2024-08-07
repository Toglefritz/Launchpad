import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:launchpad_app/services/firebase_remote_config/models/remote_config_key.dart';

/// A service class for handling Firebase Remote Config operations in the Launchpad app.
///
/// This class provides methods to initialize Remote Config settings and to fetch configuration parameters that guide
/// the behavior of the app's AI-powered features, enabling dynamic updates  and experimentation.
class RemoteConfigService {
  /// The instance of [FirebaseRemoteConfig] used for fetching remote configuration values.
  final FirebaseRemoteConfig _remoteConfig;

  /// The static instance of [RemoteConfigService] to ensure it's a singleton.
  static final RemoteConfigService _instance = RemoteConfigService._internal(FirebaseRemoteConfig.instance);

  /// Factory constructor to return the singleton instance of [RemoteConfigService].
  factory RemoteConfigService() {
    return _instance;
  }

  /// A private constructor for [RemoteConfigService] to prevent direct instantiation.
  ///
  /// The [FirebaseRemoteConfig] instance is used to fetch and activate remote configuration parameters.
  RemoteConfigService._internal(this._remoteConfig);

  /// Initializes the Remote Config settings and fetches the latest configuration values.
  ///
  /// This method sets the fetch timeout and the minimum fetch interval for Remote Config. It then fetches and
  /// activates the latest configuration values from the Firebase Remote Config server.
  ///
  /// The fetch timeout is set to 10 seconds, and the minimum fetch interval is set to 1 hour.
  ///
  /// Returns a [Future] that completes when the initialization and fetch operation is finished.
  Future<void> initialize() async {
    await _remoteConfig.setConfigSettings(
      RemoteConfigSettings(
        fetchTimeout: const Duration(seconds: 10),
        minimumFetchInterval: const Duration(minutes: 10),
      ),
    );
    try {
      await _remoteConfig.fetchAndActivate();

      debugPrint('Successfully fetched and activated Remote Config');
    } catch (e) {
      debugPrint('Fetching and activating remote config failed with exception, $e');

      rethrow;
    }
  }

  /// Returns the temperature parameter used by the AI model used for project creation.
  ///
  /// The temperature parameter controls the randomness of the AI model's responses. A higher temperature value results
  /// in more random responses, while a lower value results in more deterministic responses. This value is fetched from
  /// the remote configuration under the key `temperature`.
  ///
  /// Returns a [double] containing the temperature parameter.
  double getProjectCreationTemperature() {
    return _remoteConfig.getDouble(RemoteConfigKey.projectCreationTemperature.key);
  }

  /// Returns the temperature parameter used by the AI model used for asking questions about the project.
  ///
  /// The temperature parameter controls the randomness of the AI model's responses. A higher temperature value results
  /// in more random responses, while a lower value results in more deterministic responses. This value is fetched from
  /// the remote configuration under the key `temperature`.
  ///
  /// Returns a [double] containing the temperature parameter.
  double getProjectExploreTemperature() {
    return _remoteConfig.getDouble(RemoteConfigKey.projectCreationTemperature.key);
  }

  /// Returns the system instructions used by the AI model while creating a project.
  ///
  /// The system instructions guide the behavior of the AI model by providing specific directives. This value is
  /// fetched from the remote configuration under the key `project_creation_system_instructions`.
  ///
  /// Returns a [String] containing the system instructions.
  String getProjectCreationSystemInstructions() {
    final String systemInstructions = _remoteConfig.getString(RemoteConfigKey.projectCreationSystemInstructions.key);

    return systemInstructions;
  }

  /// Returns the system instructions used by the AI model used to enable users to ask questions about a project.
  ///
  /// The system instructions guide the behavior of the AI model by providing specific directives. This value is
  /// fetched from the remote configuration under the key `project_chat_system_instructions`.
  ///
  /// Returns a [String] containing the system instructions.
  String getProjectChatSystemInstructions() {
    final String systemInstructions = _remoteConfig.getString(RemoteConfigKey.projectChatSystemInstructions.key);

    return systemInstructions;
  }

  /// Returns the beginning portion of a prompt used to generate achievements for a project.
  ///
  /// The prompt preamble is the initial part of the prompt that is displayed to the user when generating an achievement
  /// for a project. This value is fetched from the remote configuration under the key `achievement_prompt_preamble`.
  /// Content from the project is appended to this preamble to create the full prompt.
  ///
  /// Returns a [String] containing the prompt preamble.
  String getAchievementPromptPreamble() {
    final String promptPreamble = _remoteConfig.getString(RemoteConfigKey.achievementPromptPreamble.key);

    return promptPreamble;
  }

  /// Returns a boolean value that determines whether or not cover images should be generated for projects.
  ///
  /// Generating cover images for projects can be a resource-intensive operation, both in terms of time and in terms
  /// of costs for the associated API calls. This Remote Configs parameter allows image generation to be enabled or
  /// disabled without requiring a new app release.
  bool shouldGenerateCoverImages() {
    return _remoteConfig.getBool(RemoteConfigKey.generateCoverImages.key);
  }
}
