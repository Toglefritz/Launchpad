import 'package:flutter/cupertino.dart';
import 'package:launchpad_app/services/firebase_remote_config/remote_config_service.dart';
import 'package:launchpad_app/services/image_generation/image_generation_service.dart';
import 'package:launchpad_app/services/image_generation/models/generated_image.dart';
import 'package:launchpad_app/services/project/project.dart';

/// Represents a project, derived from a [Project] object, that is augmented with additional data.
///
/// The [Project] class represents a project generated by an AI system from JSON conforming to the HowTo schema from
/// schema.org. This class represents an extension of that class, with additional data that is not part of the HowTo
/// schema. This class is used to represent projects that have been augmented with additional data, such as images
/// and links to sites from which tools and materials can be purchased. This additional data is used to enhance the
/// user experience when viewing the project by providing a richer project description.
// ignore_for_file: always_put_required_named_parameters_first
class AugmentedProject extends Project {
  /// The URL of an image representing the project. This image is created using generative AI services.
  final GeneratedImage? projectImage;

  /// Creates an instance of [AugmentedProject].
  AugmentedProject._({
    required super.name,
    required super.description,
    required super.steps,
    required super.raw,
    super.tools,
    super.supplies,
    super.tips,
    required this.projectImage,
  });

  /// Returns an instance of [AugmentedProject] from a [Project] by making additional calls to asynchronous services.
  ///
  /// This method plays a similar role to a factory constructor, but it is asynchronous and makes additional calls to
  /// services to augment the project with additional data. This method is used to create an instance of
  /// [AugmentedProject] from a [Project] object by making additional calls to services to augment the project with
  /// additional data.
  static Future<AugmentedProject> fromProject(Project project) async {
    // The Firebase Remote Config service is used to configure various options for project augmentation.
    final RemoteConfigService remoteConfigService = RemoteConfigService();

    // Get an image for the project, as long as the capability is enabled in Firebase Remote Config.
    final GeneratedImage? projectImage;
    if (remoteConfigService.shouldGenerateCoverImages()) {
      // If the capability is enabled, get an image for the project.
      projectImage = await _getProjectImage(project);
    } else {
      // If the capability is disabled, set the project image to null.
      projectImage = null;
    }

    // Construct the augmented project.
    return AugmentedProject._(
      name: project.name,
      description: project.description,
      steps: project.steps,
      raw: project.raw,
      tools: project.tools,
      supplies: project.supplies,
      tips: project.tips,
      projectImage: projectImage,
    );
  }

  /// Gets an image representing the project using generative AI services.
  static Future<GeneratedImage?> _getProjectImage(Project project) async {
    try {
      // Create a prompt for the image generation service based on the project contents.
      final String prompt = ImageGenerationService.buildPromptFromProject(project);

      // Get an image for the project using generative AI services.
      final GeneratedImage projectImage = await ImageGenerationService.generateImage(prompt);

      return projectImage;
    } catch (e) {
      debugPrint('Failed to generate image for project with exception, $e');

      return null;
    }
  }

  /// A convenience getter for the project image URL.
  String? get projectImageUrl => projectImage?.data.imageUrl;
}
