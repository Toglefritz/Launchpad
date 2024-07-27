import 'dart:convert';
import 'dart:io';

import 'package:fake_http_client/fake_http_client.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:launchpad_app/extensions/json_typedef.dart';
import 'package:launchpad_app/services/user/user_service.dart';
import 'package:mockito/mockito.dart';

import '../../mocks/mock_user.mocks.dart';
import '../../utils/mock_http_server.dart';

/// This file contains test for the [UserService] class, ensuring the correct behavior of the service methods.
///
/// This test can be run using the following command:
///
/// ```sh
/// flutter test test/services/user/user_service_test.dart
/// ```
void main() {
  group('UserService', () {
    /// Tests the successful retrieval of the user's current projects.
    ///
    /// This test sets up a mock server to respond with a successful image generation response. It verifies that the
    /// `getCurrentProjects` function correctly parses the response and returns a list of project IDs.
    test('should return current projects successfully', () async {
      // Set up the mock response body
      final JSONArray mockResponseBody = [
        'oaX6qMLGfBq2htFOsOFL',
        'fk84Kg03Wnv85llnDiw2',
      ];

      // Set up the mock response data
      final JSONObject mockResponseData = {
        'statusCode': 200,
        'body': jsonEncode(mockResponseBody),
      };

      // Create a MockHttpServer instance with the responseBuilder function
      final MockHttpServer mockServer = MockHttpServer(() {
        return FakeHttpResponse(
          statusCode: mockResponseData['statusCode'] as int,
          body: mockResponseData['body'] as String,
        );
      });

      // Set the global HttpOverrides to use the MockHttpServer
      HttpOverrides.global = mockServer;

      // Mock getting an ID token for the user
      final MockUser mockUser = MockUser();
      when(mockUser.getIdToken()).thenAnswer((_) async => 'mock_id_token');

      // Call the function under test
      final UserService userService = UserService(mockUser);
      final List<String> projects = await userService.getCurrentProjects(
        appCheckToken: 'take_token',
      );

      // Validate the response
      expect(projects.isNotEmpty, true);
      expect(projects.first, 'oaX6qMLGfBq2htFOsOFL');
      expect(projects.last, 'fk84Kg03Wnv85llnDiw2');

      // Clean up by resetting the global HttpOverrides
      HttpOverrides.global = null;
    });

    /// Tests the behavior of the `getCurrentProjects` method when the user has no projects, returning an empty list.
    ///
    /// If the user has no current projects, the Firebase Functions endpoint will return a status code of 204. This test
    /// sets up a mock server to respond with a 204 status code and verifies that the `getCurrentProjects` function
    /// returns an empty list.
    test('should handle no projects correctly', () async {
      // Set up the mock response data
      final JSONObject mockResponseData = {
        'statusCode': 204,
      };

      // Create a MockHttpServer instance with the responseBuilder function
      final MockHttpServer mockServer = MockHttpServer(() {
        return FakeHttpResponse(
          statusCode: mockResponseData['statusCode'] as int,
        );
      });

      // Set the global HttpOverrides to use the MockHttpServer
      HttpOverrides.global = mockServer;

      // Mock getting an ID token for the user
      final MockUser mockUser = MockUser();
      when(mockUser.getIdToken()).thenAnswer((_) async => 'mock_id_token');

      // Call the function under test
      final UserService userService = UserService(mockUser);
      final List<String> projects = await userService.getCurrentProjects(
        appCheckToken: 'take_token',
      );

      // Validate the response
      expect(projects.isEmpty, true);

      // Clean up by resetting the global HttpOverrides
      HttpOverrides.global = null;
    });
  });

  /// Tests the behavior of the `buildPromptFromProject` method when an error occurs.
  ///
  /// If the endpoint used to get a list of current projects returns a status code other than 200 or 204, or if any
  /// other error occurs, the `getCurrentProjects` function will throw an exception. This test sets up a mock server to
  /// respond with an error status code and verifies that the `getCurrentProjects` function throws an exception with the
  /// expected message.
  test('should handle error correctly', () async {
    // Set up the mock response data for an error
    final JSONObject mockResponseData = {
      'statusCode': 500,
    };

    // Create a MockHttpServer instance with the responseBuilder function
    final MockHttpServer mockServer = MockHttpServer(() {
      return FakeHttpResponse(
        statusCode: mockResponseData['statusCode'] as int,
      );
    });

    // Set the global HttpOverrides to use the MockHttpServer
    HttpOverrides.global = mockServer;

    // Mock getting an ID token for the user
    final MockUser mockUser = MockUser();
    when(mockUser.getIdToken()).thenAnswer((_) async => 'mock_id_token');

    // Call the function under test
    final UserService userService = UserService(mockUser);
    try {
      await userService.getCurrentProjects(
        appCheckToken: 'take_token',
      );
    } catch (e) {
      // Validate the response
      expect(e.toString(), 'Exception: Failed to read project with status code, 500');
    }

    // Clean up by resetting the global HttpOverrides
    HttpOverrides.global = null;
  });
}
