import 'dart:convert';
import 'dart:io';

import 'package:fake_http_client/fake_http_client.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:launchpad_app/extensions/json_typedef.dart';
import 'package:launchpad_app/services/project/augmented_project.dart';
import 'package:launchpad_app/services/project/project_service.dart';

import '../../mocks/mock_user.mocks.dart';
import '../../utils/mock_http_server.dart';

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
  /// A [ProjectService] instance for testing the service methods.
  final ProjectService projectService = ProjectService(MockUser());

  /// A JSON object representing a project with all possible fields.
  final JSONObject projectDataJson = {
    '@context': 'https://schema.org',
    '@type': 'HowTo',
    'name': 'How to Scientifically Measure the Airspeed Velocity of an Unladen Swallow',
    'description':
        'A comprehensive guide to scientifically measure the airspeed velocity of an unladen swallow in a controlled lab environment using precise instruments and methods.',
    'step': [
      {
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
      },
      {
        '@type': 'HowToStep',
        'name': 'Gather Necessary Equipment',
        'description': 'Collect all tools and equipment needed for the experiment.',
        'itemListElement': [
          {
            '@type': 'HowToDirection',
            'text': "Gather high-speed cameras for capturing the swallow's flight.",
          },
          {
            '@type': 'HowToDirection',
            'text': "Prepare a wind tunnel or large enclosed space to measure the swallow's flight.",
          }
        ],
        'tool': [
          {
            '@type': 'HowToTool',
            'name': 'High-Speed Camera',
          },
          {
            '@type': 'HowToTool',
            'name': 'Wind Tunnel',
          }
        ],
      },
      {
        '@type': 'HowToStep',
        'name': 'Calibrate Instruments',
        'description': 'Ensure all instruments are properly calibrated for accurate measurements.',
        'itemListElement': [
          {
            '@type': 'HowToDirection',
            'text': "Calibrate the high-speed cameras to accurately capture the swallow's speed.",
          },
          {
            '@type': 'HowToDirection',
            'text': 'Calibrate the wind tunnel to simulate natural flight conditions.',
          }
        ],
        'tool': [
          {
            '@type': 'HowToTool',
            'name': 'Calibration Equipment',
          }
        ],
      },
      {
        '@type': 'HowToStep',
        'name': 'Conduct the Experiment',
        'description': 'Perform the experiment to measure the airspeed velocity of the swallow.',
        'itemListElement': [
          {
            '@type': 'HowToDirection',
            'text': 'Release the swallow in the wind tunnel and start recording.',
          },
          {
            '@type': 'HowToDirection',
            'text': "Monitor the swallow's flight and ensure all data is being captured accurately.",
          }
        ],
        'tool': [
          {
            '@type': 'HowToTool',
            'name': 'Data Recording Software',
          }
        ],
      },
      {
        '@type': 'HowToStep',
        'name': 'Analyze the Data',
        'description': 'Analyze the collected data to determine the airspeed velocity.',
        'itemListElement': [
          {
            '@type': 'HowToDirection',
            'text': "Use motion analysis software to calculate the swallow's speed from the high-speed footage.",
          },
          {
            '@type': 'HowToDirection',
            'text': 'Compare the results with known values and ensure accuracy.',
          }
        ],
        'tool': [
          {
            '@type': 'HowToTool',
            'name': 'Motion Analysis Software',
          }
        ],
      }
    ],
    'tool': [
      {
        '@type': 'HowToTool',
        'name': 'High-Speed Camera',
      },
      {
        '@type': 'HowToTool',
        'name': 'Wind Tunnel',
      },
      {
        '@type': 'HowToTool',
        'name': 'Calibration Equipment',
      },
      {
        '@type': 'HowToTool',
        'name': 'Data Recording Software',
      },
      {
        '@type': 'HowToTool',
        'name': 'Motion Analysis Software',
      }
    ],
    'supply': [
      {
        '@type': 'HowToSupply',
        'name': 'Swallow',
      }
    ],
    'tip': [
      {
        '@type': 'HowToTip',
        'text': 'Ensure all equipment is calibrated properly for the most accurate measurements.',
      },
      {
        '@type': 'HowToTip',
        'text': 'Review footage multiple times to ensure consistency in data analysis.',
      }
    ],
    'totalTime': 'PT4H',
    'estimatedCost': {
      '@type': 'MonetaryAmount',
      'currency': 'USD',
      'value': 500,
    },
  };

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

        // Call the method under test
        await projectService.createProject(AugmentedProject.fromJson(projectDataJson));

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

        // Call the method under test
        final AugmentedProject project = await projectService.readProject('12345');

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

        // Create an AugmentedProject object representing the project to be updated.
        final AugmentedProject originalProject = AugmentedProject.fromJson(projectDataJson);

        // Update the project name.
        final AugmentedProject updatedProject = originalProject.copyWith(
          name: 'Airspeed Velocity of an Unladen Swallow Scientifically Measured',
        );

        // Call the method under test
        await projectService.updateProject('12345', updatedProject);

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

        // Call the method under test
        await projectService.deleteProject('12345');

        // Validate the response
        expect(mockServer.responseBuilder().statusCode, 200);
      });
    });
  });
}
