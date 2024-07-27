import 'package:launchpad_app/extensions/json_typedef.dart';

/// Represents the data of a generated image. This data includes a revised prompt that the AI model created based
/// on the original prompt. It also includes a URL to the generated image, stored in a Microsoft Azure Blob Storage
/// container.
///
/// The images generated by the AI model have dimensions of 1024x1024 pixels. This size is the smallest of the sizes
/// available from the model currently used by the all (DALL-E 3).
class GeneratedImageData {
  /// The revised prompt that the AI model created based on the original prompt.
  final String revisedPrompt;

  /// The URL to the generated image stored in a Microsoft Azure Blob Storage container.
  final String imageUrl;

  /// Creates a [GeneratedImageData].
  ///
  /// The [revisedPrompt] and [imageUrl] arguments must not be null.
  const GeneratedImageData({
    required this.revisedPrompt,
    required this.imageUrl,
  });

  /// Creates a [GeneratedImageData] from a JSON object.
  ///
  /// The JSON object must contain the [revisedPrompt] and [imageUrl] fields.
  factory GeneratedImageData.fromJson(JSONArray json) {
    // Get the first data object from the JSON array.
    final JSONObject firstData = json[0] as JSONObject;

    return GeneratedImageData(
      revisedPrompt: firstData['revised_prompt'] as String,
      imageUrl: firstData['url'] as String,
    );
  }

  /// Converts the [GeneratedImageData] to a JSON object.
  JSONObject toJson() {
    return {
      'revised_prompt': revisedPrompt,
      'url': imageUrl,
    };
  }
}
