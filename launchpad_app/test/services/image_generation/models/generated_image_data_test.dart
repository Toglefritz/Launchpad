import 'package:flutter_test/flutter_test.dart';
import 'package:launchpad_app/extensions/json_typedef.dart';
import 'package:launchpad_app/services/image_generation/models/generated_image_data.dart';

/// Test suite for the [GeneratedImageData] class.
///
/// This test can be run using the following command:
///
/// ```sh
/// flutter test test/services/image_generation/models/generated_image_data_test.dart
/// ```
void main() {
  /// Test group for the [GeneratedImageData.fromJson] factory constructor and the [GeneratedImageData.toJson] method
  /// of [GeneratedImageData].
  group('GeneratedImageData', () {
    /// Tests that the [GeneratedImageData.fromJson] factory constructor correctly creates an instance with the correct
    /// fields.
    test('fromJson creates an instance with correct fields', () {
      // Sample JSON array
      final JSONArray sampleJson = [
        {
          'revised_prompt': 'A revised prompt',
          'url': 'https://example.com/image.png',
        },
      ];

      // Create a GeneratedImageData instance using the fromJson factory constructor
      final GeneratedImageData generatedImageData = GeneratedImageData.fromJson(sampleJson);

      // Verify that the fields match the expected values
      expect(generatedImageData.revisedPrompt, 'A revised prompt');
      expect(generatedImageData.imageUrl, 'https://example.com/image.png');
    });

    /// Tests that the [GeneratedImageData.toJson] method converts an instance to JSON correctly.
    test('toJson converts an instance to JSON correctly', () {
      // Create a GeneratedImageData instance
      const GeneratedImageData generatedImageData = GeneratedImageData(
        revisedPrompt: 'A revised prompt',
        imageUrl: 'https://example.com/image.png',
      );

      // Convert the instance to JSON
      final JSONArray json = generatedImageData.toJson();

      // Expected JSON array
      final JSONArray expectedJson = [
        {
          'revised_prompt': 'A revised prompt',
          'url': 'https://example.com/image.png',
        },
      ];

      // Verify that the resulting JSON matches the expected JSON
      expect(json, expectedJson);
    });
  });
}
