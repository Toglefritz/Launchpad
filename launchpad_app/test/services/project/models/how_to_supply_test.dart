import 'package:flutter_test/flutter_test.dart';
import 'package:launchpad_app/extensions/json_typedef.dart';
import 'package:launchpad_app/services/project/models/how_to_supply.dart';

/// Test suite for the [HowToSupply] class.
///
/// This suite includes tests for the `fromJson` factory constructor and the `toJson` method. It verifies that
/// instances of [HowToSupply] are created correctly from JSON data and that they can be converted to JSON correctly.
///
/// This test can be run using the following command:
///
/// ```sh
/// flutter test test/services/project/models/how_to_supply_test.dart
/// ```
void main() {
  /// Test group for the [HowToSupply] class.
  group('HowToSupply', () {
    HowToSupply? supply;

    setUpAll(() {
      // Sample JSON object
      final JSONObject sampleJson = {
        '@type': 'HowToSupply',
        'name': 'Adequate Lighting',
      };

      // Create a HowToSupply instance using the fromJson factory constructor
      supply = HowToSupply.fromJson(sampleJson);
    });

    /// Test that verifies the `fromJson` factory constructor creates an instance with correct fields.
    test('fromJson creates an instance with correct fields', () {
      // Verify that the fields match the expected values
      expect(supply?.name, isNotNull);
      expect(supply?.name, 'Adequate Lighting');
    });

    /// Test that verifies the `toJson` method converts an instance to JSON correctly.
    test('toJson converts an instance to JSON correctly', () {
      // Convert the instance to JSON
      final JSONObject json = supply!.toJson();

      // Verify that the resulting JSON matches the expected JSON
      expect(json, isNotEmpty);
      expect(json['name'], 'Adequate Lighting');
    });
  });
}
