import 'package:flutter_test/flutter_test.dart';
import 'package:launchpad_app/extensions/json_typedef.dart';
import 'package:launchpad_app/services/project/models/how_to_tip.dart';

/// Test suite for the [HowToTip] class.
///
/// This suite includes tests for the `fromJson` factory constructor and the `toJson` method. It verifies that
/// instances of [HowToTip] are created correctly from JSON data and that they can be converted to JSON correctly.
///
/// This test can be run using the following command:
///
/// ```sh
/// flutter test test/services/project/models/how_to_tip_test.dart
/// ```
void main() {
  /// Test group for the [HowToTip] class.
  group('HowToTip', () {
    HowToTip? tip;

    setUpAll(() {
      // Sample JSON object
      final JSONObject sampleJson = {
        '@type': 'HowToTip',
        'text': 'Ensure all equipment is calibrated properly for the most accurate measurements.',
      };

      // Create a HowToTip instance using the fromJson factory constructor
      tip = HowToTip.fromJson(sampleJson);
    });

    /// Test that verifies the `fromJson` factory constructor creates an instance with correct fields.
    test('fromJson creates an instance with correct fields', () {
      // Verify that the fields match the expected values
      expect(tip?.text, isNotNull);
      expect(tip?.text, 'Ensure all equipment is calibrated properly for the most accurate measurements.');
    });

    /// Test that verifies the `toJson` method converts an instance to JSON correctly.
    test('toJson converts an instance to JSON correctly', () {
      // Convert the instance to JSON
      final JSONObject json = tip!.toJson();

      // Verify that the resulting JSON matches the expected JSON
      expect(json, isNotEmpty);
      expect(json['text'], 'Ensure all equipment is calibrated properly for the most accurate measurements.');
    });
  });
}
