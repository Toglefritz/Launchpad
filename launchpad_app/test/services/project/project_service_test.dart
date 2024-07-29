import 'dart:convert';
import 'dart:io';

import 'package:fake_http_client/fake_http_client.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:launchpad_app/extensions/json_typedef.dart';
import 'package:launchpad_app/services/project/augmented_project.dart';
import 'package:launchpad_app/services/project/project_service.dart';
import 'package:mockito/mockito.dart';

import '../../mocks/mock_user.mocks.dart';
import '../../utils/mock_http_server.dart';
import '../../utils/project_data_json.dart';

/// This file contains tests for the [ProjectService] class, ensuring the correct behavior of the service methods.
///
/// The [ProjectService] class contains methods for creating, reading, updating, and deleting projects. These tests
/// cover the behavior of each method, including successful and unsuccessful responses from the Firebase Functions
/// endpoint. Each CRUD operation is tested in its own group to ensure that the service behaves as expected.
///
/// This test can be run using the following command:
///
/// ```sh
/// flutter test test/services/project/project_service_test.dart
/// ```
void main() {
  /// Tests the behavior of the [ProjectService] class.
  group('ProjectService', () {
    /// Tests that the `createProject` method.
    group('createProject', () {
      /// Tests that the `createProject` method successfully creates a project when it is called with valid data and
      /// when the Firebase Functions endpoint returns a status code of 201.
      test('should create project successfully', () async {
        final JSONObject mockResponseData = {
          'statusCode': 201,
          'body': jsonEncode({'projectId': '12345'}),
        };

        final MockHttpServer mockServer = MockHttpServer(() {
          return FakeHttpResponse(
            statusCode: mockResponseData['statusCode'] as int,
            body: mockResponseData['body'] as String,
          );
        });

        HttpOverrides.global = mockServer;

        // Mock getting an ID token for the user
        final MockUser mockUser = MockUser();
        when(mockUser.getIdToken()).thenAnswer((_) async => 'mock_id_token');

        // Call the method under test
        final ProjectService projectService = ProjectService(mockUser);
        await projectService.createProject(
          augmentedProject: await AugmentedProject.fromJson(projectDataJson),
          appCheckToken: 'mock_app_check_token',
        );

        // Validate the response
        expect(mockServer.responseBuilder().statusCode, 201);
      });
    });

    group('readProject', () {
      test('should read project successfully', () async {
        final JSONObject mockResponseBody = projectDataJson;

        final JSONObject mockResponseData = {
          'statusCode': 200,
          'body': jsonEncode(mockResponseBody),
        };

        final MockHttpServer mockServer = MockHttpServer(() {
          return FakeHttpResponse(
            statusCode: mockResponseData['statusCode'] as int,
            body: mockResponseData['body'] as String,
          );
        });

        HttpOverrides.global = mockServer;

        // Mock getting an ID token for the user
        final MockUser mockUser = MockUser();
        when(mockUser.getIdToken()).thenAnswer((_) async => 'mock_id_token');

        // Call the method under test
        final ProjectService projectService = ProjectService(mockUser);
        final AugmentedProject project = await projectService.readProject(
          projectId: '12345',
          appCheckToken: 'mock_app_check_token',
        );

        // Validate the response. Note that there is also an implicit validation test here because the test will
        // fail if an exception is thrown while parsing the response JSON.
        expect(project.name, 'How to Scientifically Measure the Airspeed Velocity of an Unladen Swallow');
        expect(
          project.description,
          'A comprehensive guide to scientifically measure the airspeed velocity of an unladen swallow in a controlled lab environment using precise instruments and methods.',
        );
      });
    });

    group('updateProject', () {
      test('should update project successfully', () async {
        final JSONObject mockResponseData = {
          'statusCode': 200,
          'body': 'Project updated successfully',
        };

        final MockHttpServer mockServer = MockHttpServer(() {
          return FakeHttpResponse(
            statusCode: mockResponseData['statusCode'] as int,
            body: mockResponseData['body'] as String,
          );
        });

        HttpOverrides.global = mockServer;

        // Mock getting an ID token for the user
        final MockUser mockUser = MockUser();
        when(mockUser.getIdToken()).thenAnswer((_) async => 'mock_id_token');

        // Create an AugmentedProject object representing the project to be updated.
        final AugmentedProject originalProject = await AugmentedProject.fromJson(projectDataJson);

        // Update the project name.
        final AugmentedProject updatedProject = originalProject.copyWith(
          name: 'Airspeed Velocity of an Unladen Swallow Scientifically Measured',
        );

        // Call the method under test
        final ProjectService projectService = ProjectService(mockUser);
        await projectService.updateProject(
          projectId: '12345',
          updatedProject: updatedProject,
          appCheckToken: 'mock_app_check_token',
        );

        // Validate the response
        expect(mockServer.responseBuilder().statusCode, 200);
      });
    });

    group('deleteProject', () {
      test('should delete project successfully', () async {
        final JSONObject mockResponseData = {
          'statusCode': 200,
          'body': 'Project deleted successfully',
        };

        final MockHttpServer mockServer = MockHttpServer(() {
          return FakeHttpResponse(
            statusCode: mockResponseData['statusCode'] as int,
            body: mockResponseData['body'] as String,
          );
        });

        HttpOverrides.global = mockServer;

        // Mock getting an ID token for the user
        final MockUser mockUser = MockUser();
        when(mockUser.getIdToken()).thenAnswer((_) async => 'mock_id_token');

        // Call the method under test
        final ProjectService projectService = ProjectService(mockUser);
        await projectService.deleteProject(
          projectId: '12345',
          appCheckToken: 'mock_app_check_token',
        );

        // Validate the response
        expect(mockServer.responseBuilder().statusCode, 200);
      });
    });
  });
}
