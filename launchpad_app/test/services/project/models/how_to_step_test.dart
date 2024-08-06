import 'dart:convert';
import 'dart:io';

import 'package:fake_http_client/fake_http_client.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:launchpad_app/extensions/json_typedef.dart';
import 'package:launchpad_app/services/project/models/how_to_step.dart';
import 'package:mockito/mockito.dart';

import '../../../mocks/mock_user.mocks.dart';
import '../../../utils/mock_http_server.dart';

/// Test suite for the [HowToStep] class.
///
/// This suite includes tests for the `fromJson` factory constructor, the `toJson` method, the `setActive`, and the
/// `isCompleted` getter. It verifies that instances of [HowToStep] are created correctly from JSON data, that they
/// can be converted to JSON correctly, that the `setActive` method works as expected, and that the `isCompleted`
/// getter behaves as expected, under different scenarios.
///
/// This test can be run using the following command:
///
/// ```sh
/// flutter test test/services/project/models/how_to_step_test.dart
/// ```
void main() {
  /// Test group for the [HowToStep] class.
  group('HowToStep', () {
    HowToStep? step;

    setUpAll(() {
      // Sample JSON object
      final JSONObject sampleJson = {
        '@type': 'HowToStep',
        'name': 'Prepare the Lab Environment',
        'description': 'Set up the lab with the necessary equipment and safety measures.',
        'itemListElement': [
          {
            '@type': 'HowToDirection',
            'text': 'Ensure the lab is equipped with adequate lighting and space for the experiment.',
          },
          {
            '@type': 'HowToDirection',
            'text': 'Set up safety barriers and equipment to protect the swallow and the researchers.',
          }
        ],
        'tool': [
          {
            '@type': 'HowToTool',
            'name': 'Lab Space',
          },
          {
            '@type': 'HowToTool',
            'name': 'Safety Barriers',
          }
        ],
      };

      // Create a HowToStep instance using the fromJson factory constructor
      step = HowToStep.fromJson(sampleJson);
    });

    /// Test group for the methods related to consuming and producing JSON data.
    group('JSON handling', () {
      /// Test that verifies the `fromJson` factory constructor creates an instance with correct fields.
      test('fromJson creates an instance with correct fields', () {
        // Verify that the fields match the expected values
        expect(step?.id, isNotNull);
        expect(step?.id, isNotEmpty);
        expect(step?.name, 'Prepare the Lab Environment');
        expect(step?.description, 'Set up the lab with the necessary equipment and safety measures.');
        expect(step?.directions.length, 2);
        expect(step?.directions.first.id, isNotNull);
        expect(step?.directions.first.id, isNotEmpty);
        expect(step?.tools!.length, 2);
        expect(step?.tools!.first.name, 'Lab Space');
        expect(step?.supplies, isNull);
      });

      /// Test that verifies the `toJson` method converts an instance to JSON correctly.
      test('toJson converts an instance to JSON correctly', () {
        // Convert the instance to JSON
        final JSONObject json = step!.toJson();

        // Verify that the resulting JSON matches the expected JSON
        expect(json, isNotEmpty);
        expect(json['id'], isNotNull);
        expect(json['id'], isNotEmpty);
        expect(json['name'], 'Prepare the Lab Environment');
        expect(json['description'], 'Set up the lab with the necessary equipment and safety measures.');
        expect(json['itemListElement'], isNotNull);
        expect(json['itemListElement'], isNotEmpty);
        expect(json['tool'], isNotNull);
        expect(json['tool'], isNotEmpty);
        expect(json['supply'], isNull);
      });
    });

    /// Test group for the `setActive` method.
    group('isComplete method', () {
      final MockUser mockUser = MockUser();

      /// Test that verifies the `markAsComplete` method successfully marks the direction as complete when the server
      /// responds with a 200 status code.
      ///
      /// This test ensures that the `isComplete` property of the direction is set to `true` when the `markAsComplete`
      /// method is called and the server responds with a successful status code.
      test('should mark the direction as complete successfully', () async {
        // Create a mock response object with the expected status code and response body.
        final JSONObject mockResponseData = {
          'statusCode': 200,
          'body': jsonEncode('Current step updated successfully'),
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
        await step?.setActive(
          user: mockUser,
          appCheckToken: 'mock_app_check_token',
          projectId: 'mock_project_id',
        );

        // Verify that the direction is marked as complete.
        expect(mockServer.responseBuilder().statusCode, 200);
        expect(step?.active, isTrue);
      });
    });

    /// Test group for the `isComplete` method.
    group('isComplete method', () {
      /// Test that verifies the `isCompleted` getter behaves as expected.
      test('returns false initially', () {
        // Verify that isCompleted returns true
        expect(step?.isCompleted, isFalse);
      });

      /// Test that verifies the `isCompleted` getter behaves as expected.
      test('returns true after all steps have been completed', () {
        // Mark all directions within the step as completed
        step?.directions.forEach((direction) => direction.isComplete = true);

        // Verify that isCompleted returns false
        expect(step?.isCompleted, isTrue);
      });
    });
  });
}
