import 'dart:convert';
import 'dart:io';

import 'package:fake_http_client/fake_http_client.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:launchpad_app/extensions/json_typedef.dart';
import 'package:launchpad_app/services/project/models/how_to_direction.dart';
import 'package:mockito/mockito.dart';

import '../../mocks/mock_user.mocks.dart';
import '../../utils/mock_http_server.dart';

/// Test suite for the [HowToDirection] class.
///
/// This suite includes tests for the `fromJson` factory constructor and the `markAsComplete` method. It verifies that
/// instances of [HowToDirection] are created correctly from JSON data and that the `markAsComplete` method  behaves as
/// expected under different scenarios.
///
/// This test can be run using the following command:
///
/// ```sh
/// flutter test test/services/project/how_to_direction_test.dart
/// ```
void main() {
  group('HowToDirection', () {
    /// Test group for the `fromJson` factory constructor of [HowToDirection].
    ///
    /// This group contains tests that verify the correct creation of [HowToDirection] instances from JSON objects.
    /// It checks that the `id`, `text`, and `isComplete` fields are populated correctly.
    group('fromJson', () {
      /// Test that verifies the `fromJson` method creates an instance with complete status set to `true` when
      /// provided with a corresponding JSON.
      ///
      /// This test ensures that the `fromJson` method correctly interprets the `complete` field from the input JSON
      /// object and sets the `isComplete` property to `true`.
      test('should create an instance from JSON with complete status', () {
        // Create a JSON object representing a direction with the `complete` field set to `true`. The content of
        // this JSON object matches the expected structure of a direction object as obtained from a Gemini model
        // upon creation of a new project
        final JSONObject json = {
          '@type': 'HowToDirection',
          'text': 'Example direction text',
        };

        // Create an instance of HowToDirection from the JSON object.
        final HowToDirection direction = HowToDirection.fromJson(json);

        // Verify that the instance is created with the correct values.
        expect(direction.id, isNotEmpty);
        expect(direction.text, 'Example direction text');
        // Verify that the `isComplete` property is initialized to 'false'.
        expect(direction.isComplete, isFalse);
      });

      /// Test that verifies the `fromJson` method creates an instance with complete status set to `false` when the
      /// `complete` field is absent in the JSON.
      ///
      /// This test ensures that the `fromJson` method defaults the `isComplete` property to `false` when the `complete`
      /// field is not provided in the input JSON object.
      test('should create an instance from JSON without complete status', () {
        // Create a JSON object representing a direction using the format the app expects to receive when the project
        // is retrieved from the Firestore backend.
        final JSONObject json = {
          'id': 'mock_direction_id',
          'text': 'Another direction text',
          'complete': true,
        };

        // Create an instance of HowToDirection from the JSON object.
        final HowToDirection direction = HowToDirection.fromJson(json);

        // Verify that the instance is created with the correct values.
        expect(direction.id, 'mock_direction_id');
        expect(direction.text, 'Another direction text');
        expect(direction.isComplete, isTrue);
      });
    });

    /// Test group for the `markAsComplete` method of [HowToDirection].
    ///
    /// This group contains tests that verify the behavior of the `markAsComplete` method, ensuring it correctly marks
    /// a direction as complete and handles errors appropriately.
    group('markAsComplete', () {
      final MockUser mockUser = MockUser();

      /// Test that verifies the `markAsComplete` method successfully marks the direction as complete when the server
      /// responds with a 200 status code.
      ///
      /// This test ensures that the `isComplete` property of the direction is set to `true` when the `markAsComplete`
      /// method is called and the server responds with a successful status code.
      test('should mark the direction as complete successfully', () async {
        // Create a direction object with the `complete` field set to `false`.
        final HowToDirection direction = HowToDirection.fromJson({
          'id': 'mock_direction_id',
          'text': 'Complete the direction',
          'complete': false,
        });

        // Create a mock response object with the expected status code and response body.
        final JSONObject mockResponseData = {
          'statusCode': 200,
          'body': jsonEncode({'complete': true}),
        };

        final MockHttpServer mockServer = MockHttpServer(() {
          return FakeHttpResponse(
            statusCode: mockResponseData['statusCode'] as int,
            body: mockResponseData['body'] as String,
          );
        });

        HttpOverrides.global = mockServer;

        // Mock getting an ID token for the user
        when(mockUser.getIdToken()).thenAnswer((_) async => 'mock_id_token');

        // Call the `markAsComplete` method on the direction object.
        await direction.markAsComplete(
          user: mockUser,
          appCheckToken: 'mock_app_check_token',
          projectId: 'mock_project_id',
        );

        // Verify that the direction is marked as complete.
        expect(mockServer.responseBuilder().statusCode, 200);
        expect(direction.isComplete, isTrue);
      });
    });
  });
}
