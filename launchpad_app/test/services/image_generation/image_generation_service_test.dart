import 'dart:convert';
import 'dart:io';
import 'package:fake_http_client/fake_http_client.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:launchpad_app/extensions/json_typedef.dart';
import 'package:launchpad_app/services/image_generation/image_generation_service.dart';
import 'package:launchpad_app/services/image_generation/models/generated_image.dart';
import 'package:mockito/mockito.dart';
import '../../mocks/mock_user.mocks.dart';
import '../../utils/mock_http_server.dart';

/// Tests for the [ImageGenerationService] class, specifically the `generateImage` function.
///
/// The `generateImage` function is responsible for making a POST request to a Firebase Functions endpoint to generate
/// an image based on the provided prompt. These tests use [MockHttpServer] to mock HTTP responses and validate the
/// behavior of the function under different scenarios.
///
/// Before running these tests, ensure that the following command has been run to generate mocks:
///
/// ```sh
/// dart pub run build_runner build
/// ```
///
/// These tests can be run using the following command:
///
/// ```sh
/// flutter test test/services/image_generation/image_generation_service_test.dart
/// ```
void main() {
  group('ImageGenerationService', () {
    /// Tests the successful generation of an image.
    ///
    /// This test sets up a mock server to respond with a successful image generation response. It verifies that the
    /// `generateImage` function correctly parses the response and returns a [GeneratedImage] object with the expected
    /// properties.
    test('should generate image successfully', () async {
      // Set up the mock response body
      final JSONObject mockResponseBody = {
        'created': 1089336896,
        'data': [
          {
            'revised_prompt': 'A photograph of a swallow carrying a coconut.',
            'url': 'https://example.com/generated_image.png',
          },
        ],
      };

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
      final GeneratedImage generatedImage = await ImageGenerationService.generateImage(
        user: mockUser,
        appCheckToken: 'take_token',
        prompt: 'sample prompt',
      );

      // Validate the response
      expect(generatedImage.timestamp, 1089336896);
      expect(generatedImage.data.revisedPrompt, 'A photograph of a swallow carrying a coconut.');
      expect(generatedImage.data.imageUrl, 'https://example.com/generated_image.png');

      // Clean up by resetting the global HttpOverrides
      HttpOverrides.global = null;
    });
  });

  /// Tests the handling of an unauthorized error.
  ///
  /// This test sets up a mock server to respond with an unauthorized error. It verifies that the `generateImage`
  /// function throws an exception with the expected message when an unauthorized error occurs.
  test('should handle unauthorized error', () async {
    // Set up the mock response data for unauthorized error
    final JSONObject mockResponseData = {
      'statusCode': 401,
      'body': jsonEncode({'error': 'Unauthorized'}),
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

    // Call the function under test and expect an exception with the specific message
    try {
      await ImageGenerationService.generateImage(
        user: mockUser,
        appCheckToken: 'mock_app_check_token',
        prompt: 'sample prompt',
      );
    } catch (e) {
      expect(e, isA<Exception>().having((e) => e.toString(), 'message', contains('Unauthorized')));
    }

    // Clean up by resetting the global HttpOverrides
    HttpOverrides.global = null;
  });

  /// Tests the handling of an internal server error.
  ///
  /// This test sets up a mock server to respond with an internal server error. It verifies that the `generateImage`
  /// function throws an exception with the expected message when an internal server error occurs.
  test('should handle unauthorized error', () async {
    // Set up the mock response data for unauthorized error
    final JSONObject mockResponseData = {
      'statusCode': 500,
      'body': jsonEncode({'error': 'Internal Server Error'}),
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

    // Call the function under test and expect an exception with the specific message
    try {
      await ImageGenerationService.generateImage(
        user: mockUser,
        appCheckToken: 'mock_app_check_token',
        prompt: 'sample prompt',
      );
    } catch (e) {
      expect(e, isA<Exception>().having((e) => e.toString(), 'message', contains('Internal Server Error')));
    }

    // Clean up by resetting the global HttpOverrides
    HttpOverrides.global = null;
  });
}
