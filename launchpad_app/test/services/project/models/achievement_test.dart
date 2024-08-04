import 'dart:convert';
import 'dart:io';

import 'package:fake_http_client/fake_http_client.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:launchpad_app/extensions/json_typedef.dart';
import 'package:launchpad_app/services/project/models/achievement.dart';
import 'package:mockito/mockito.dart';

import '../../../mocks/mock_user.mocks.dart';
import '../../../utils/mock_http_server.dart';

/// Test suite for the [Achievement] class.
///
/// This suite includes tests for the `fromJson` factory constructor and the `markAsComplete` method. It verifies that
/// instances of [Achievement] are created correctly from JSON data and that the `markAsComplete` method  behaves as
/// expected under different scenarios.
///
/// This test can be run using the following command:
///
/// ```sh
/// flutter test test/services/project/models/achievement_test.dart
/// ```
void main() {
  group('Achievement', () {
    /// Test group for the `fromJson` factory constructor of [Achievement].
    ///
    /// This group contains tests that verify the correct creation of [Achievement] instances from JSON objects.
    /// It checks that the `id`, `text`, and `isComplete` fields are populated correctly.
    group('fromJson', () {
      /// Test that verifies the `fromJson` method creates an instance with complete status set to `false` when
      /// the class is instantiated from a JSON object without the `complete` field.
      test('should create an instance from JSON without a complete status', () {
        // Create a JSON object representing an achievement with the `complete` field set to `true`. The content of
        // this JSON object matches the expected structure of a direction object as obtained from a Gemini model
        // upon creation of a new project
        final JSONObject json = {
          'id': '74ff642c-ff27-e0e1-5d89-20deaa1489a3',
          'name': 'Example achievement title',
          'description': 'Example achievement description',
        };

        // Create an instance of Achievement from the JSON object.
        final Achievement achievement = Achievement.fromJson(json);

        // Verify that the instance is created with the correct values.
        expect(achievement.id, isNotEmpty);
        expect(achievement.title, 'Example achievement title');
        expect(achievement.description, 'Example achievement description');
        // Verify that the `isComplete` property is initialized to 'false'.
        expect(achievement.isComplete, isFalse);
      });

      /// Test that verifies the `fromJson` method creates an instance with complete status set to `true` when the
      /// `complete` field is present in the JSON.
      test('should create an instance from JSON without complete status', () {
        // Create a JSON object representing a direction using the format the app expects to receive when the project
        // is retrieved from the Firestore backend.
        final JSONObject json = {
          'id': '74ff642c-ff27-e0e1-5d89-20deaa1489a3',
          'name': 'Another example achievement title',
          'description': 'Another example achievement description',
          'complete': true,
        };

        // Create an instance of HowToDirection from the JSON object.
        final Achievement direction = Achievement.fromJson(json);

        // Verify that the instance is created with the correct values.
        expect(direction.id, '74ff642c-ff27-e0e1-5d89-20deaa1489a3');
        expect(direction.title, 'Another example achievement title');
        expect(direction.description, 'Another example achievement description');
        expect(direction.isComplete, isTrue);
      });
    });

    /// Test group for the `markAsComplete` method of [Achievement].
    ///
    /// This group contains tests that verify the behavior of the `markAsComplete` method, ensuring it correctly marks
    /// a direction as complete and handles errors appropriately.
    group('markAsComplete', () {
      final MockUser mockUser = MockUser();

      /// Test that verifies the `markAsComplete` method successfully marks the achievement as complete when the server
      /// responds with a 200 status code.
      ///
      /// This test ensures that the `isComplete` property of the direction is set to `true` when the `markAsComplete`
      /// method is called and the server responds with a successful status code.
      test('should mark the direction as complete successfully', () async {
        // Create an achievement object with the `complete` field set to `false`.
        final Achievement achievement = Achievement.fromJson({
          'id': '74ff642c-ff27-e0e1-5d89-20deaa1489a3',
          'name': 'Another example achievement title',
          'description': 'Another example achievement description',
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
        await achievement.markAsComplete(
          user: mockUser,
          appCheckToken: 'mock_app_check_token',
          projectId: '74ff642c-ff27-e0e1-5d89-20deaa1489a3',
        );

        // Verify that the direction is marked as complete.
        expect(mockServer.responseBuilder().statusCode, 200);
        expect(achievement.isComplete, isTrue);
      });
    });
  });
}
