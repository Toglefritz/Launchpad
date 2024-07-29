/// An enumeration of keys used to fetch remote configuration values from Firebase Remote Config.
enum RemoteConfigKey {
  /// The key used to fetch the temperature parameter from the remote configuration.
  temperature('temperature'),

  /// The key used to fetch the system instructions from the remote configuration for a model used in the process
  /// of creating a project.
  projectCreationSystemInstructions('project_creation_system_instructions'),

  /// The key used to fetch the prompt preamble used to build a prompt for the project achievement generation process.
  achievementPromptPreamble('achievement_prompt_preamble'),

  /// The key used to fetch a boolean value that determines whether or not cover images should be generated for
  /// projects.
  generateCoverImages('generate_project_images');

  /// The key used to fetch the configuration parameter from the remote configuration.
  final String key;

  /// Creates an instance of [RemoteConfigKey] with the given key.
  const RemoteConfigKey(this.key);
}
