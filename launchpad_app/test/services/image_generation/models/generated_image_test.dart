import 'package:flutter_test/flutter_test.dart';
import 'package:launchpad_app/extensions/json_typedef.dart';
import 'package:launchpad_app/services/image_generation/models/generated_image.dart';

/// Test suite for the [GeneratedImage] class.
///
/// This test can be run using the following command:
///
/// ```sh
/// flutter test test/services/image_generation/models/generated_image_test.dart
/// ```
void main() {
  /// This group of tests is responsible for testing the [GeneratedImage.fromJson] factory constructor.
  group('GeneratedImage', () {
    /// Tests that the [GeneratedImage.fromJson] factory constructor correctly creates an instance with the correct
    /// `fileName` field.
    test('fromJson creates an instance with correct fileName', () {
      // Sample JSON object
      final JSONObject sampleJson = {
        'fileName': 'sample-file-name',
      };

      // Create a GeneratedImage instance using the fromJson factory constructor
      final GeneratedImage generatedImage = GeneratedImage.fromJson(sampleJson);

      // Verify that the fileName field matches the expected value
      expect(generatedImage.fileName, 'sample-file-name');
    });
  });
}
