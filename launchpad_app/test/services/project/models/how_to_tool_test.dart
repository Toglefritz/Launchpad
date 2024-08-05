import 'package:flutter_test/flutter_test.dart';
import 'package:launchpad_app/extensions/json_typedef.dart';
import 'package:launchpad_app/services/project/models/how_to_tool.dart';

/// Test suite for the [HowToTool] class.
///
/// This suite includes tests for the `fromJson` factory constructor and the `toJson` method. It verifies that
/// instances of [HowToTool] are created correctly from JSON data and that they can be converted to JSON correctly.
///
/// This test can be run using the following command:
///
/// ```sh
/// flutter test test/services/project/models/how_to_tool_test.dart
/// ```
void main() {
  /// Test group for the [HowToTool] class.
  group('HowToTool', () {
    HowToTool? tool;

    setUpAll(() {
      // Sample JSON object
      final JSONObject sampleJson = {
        '@type': 'HowToTool',
        'name': 'High-Speed Camera',
      };

      // Create a HowToTool instance using the fromJson factory constructor
      tool = HowToTool.fromJson(sampleJson);
    });

    /// Test that verifies the `fromJson` factory constructor creates an instance with correct fields.
    test('fromJson creates an instance with correct fields', () {
      // Verify that the fields match the expected values
      expect(tool?.name, isNotNull);
      expect(tool?.name, 'High-Speed Camera');
    });

    /// Test that verifies the `toJson` method converts an instance to JSON correctly.
    test('toJson converts an instance to JSON correctly', () {
      // Convert the instance to JSON
      final JSONObject json = tool!.toJson();

      // Verify that the resulting JSON matches the expected JSON
      expect(json, isNotEmpty);
      expect(json['name'], 'High-Speed Camera');
    });
  });
}
