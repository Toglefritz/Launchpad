import 'package:flutter_test/flutter_test.dart';
import 'package:launchpad_app/extensions/json_typedef.dart';
import 'package:launchpad_app/services/project/models/how_to_step.dart';
import 'package:launchpad_app/services/project/models/how_to_supply.dart';
import 'package:launchpad_app/services/project/models/how_to_tip.dart';
import 'package:launchpad_app/services/project/models/how_to_tool.dart';
import 'package:launchpad_app/services/project/project.dart';

/// This file contains tests for the [Project] class, ensuring the correct parsing of JSON objects conforming to the
/// schema.org HowTo schema. The tests cover various scenarios, including handling of all fields, missing optional
/// fields, missing required fields, and empty lists.
///
/// This test can be run using the following command:
///
/// ```sh
/// flutter test test/services/project/project_test.dart
/// ```
void main() {
  group('Project.fromJson', () {
    /// Tests that the Project.fromJson factory constructor correctly parses all fields from a valid JSON object.
    ///
    /// This test provides a JSON object containing all possible fields for a project, including
    /// name, description, steps, tools, supplies, and tips. It verifies that each field is correctly
    /// parsed and that the resulting Project object contains the expected values.
    test('should parse JSON with all fields present', () {
      final JSONObject json = {
        '@context': 'https://schema.org',
        '@type': 'HowTo',
        'name': 'Build a Simple Mobile App',
        'description': 'A project guide to help you build a simple mobile application from scratch.',
        'step': [
          {
            '@type': 'HowToStep',
            'name': 'Setup Development Environment',
            'description': 'Install Flutter and set up your IDE.',
            'itemListElement': [
              {
                '@type': 'HowToDirection',
                'text': 'Install Flutter and set up your IDE.',
              },
            ],
            'tool': [
              {
                '@type': 'HowToTool',
                'name': 'Computer',
              },
            ],
          },
          {
            '@type': 'HowToStep',
            'name': 'Create a New Flutter Project',
            'description': "Create a new Flutter project using the 'flutter create' command.",
            'itemListElement': [
              {
                '@type': 'HowToDirection',
                'text': "Open your terminal and run 'flutter create my_app'.",
              },
            ],
            'tool': [
              {
                '@type': 'HowToTool',
                'name': 'Internet Connection',
              },
            ],
          },
        ],
        'tool': [
          {
            '@type': 'HowToTool',
            'name': 'Computer',
          },
          {
            '@type': 'HowToTool',
            'name': 'Internet Connection',
          },
        ],
        'supply': [
          {
            '@type': 'HowToSupply',
            'name': 'Flutter SDK',
          },
        ],
        'tip': [
          {
            '@type': 'HowToTip',
            'text': 'Make sure your Flutter SDK is up to date.',
          },
        ],
      };

      final Project project = Project.fromJson(json);

      expect(project.name, 'Build a Simple Mobile App');
      expect(project.description, 'A project guide to help you build a simple mobile application from scratch.');
      expect(project.steps.length, 2);
      expect(project.steps.first.name, 'Setup Development Environment');
      expect(project.steps.first.description, 'Install Flutter and set up your IDE.');
      expect(project.tools?.length, 2);
      expect(project.supplies?.length, 1);
      expect(project.tips?.length, 1);
    });

    /// Tests that the Project.fromJson factory constructor correctly handles missing optional fields.
    ///
    /// This test provides a JSON object that omits optional fields like tools, supplies, and tips.
    /// It verifies that the Project object is correctly instantiated with the remaining fields and
    /// that the missing optional fields are handled gracefully, without causing errors.
    test('should handle missing optional fields', () {
      final JSONObject json = {
        '@context': 'https://schema.org',
        '@type': 'HowTo',
        'name': 'Build a Simple Mobile App',
        'description': 'A project guide to help you build a simple mobile application from scratch.',
        'step': [
          {
            '@type': 'HowToStep',
            'name': 'Setup Development Environment',
            'description': 'Install Flutter and set up your IDE.',
            'itemListElement': [
              {
                '@type': 'HowToDirection',
                'text': 'Install Flutter and set up your IDE.',
              }
            ],
          },
        ],
      };

      final Project project = Project.fromJson(json);

      expect(project.name, 'Build a Simple Mobile App');
      expect(project.description, 'A project guide to help you build a simple mobile application from scratch.');
      expect(project.steps.length, 1);
      expect(project.steps.first.name, 'Setup Development Environment');
      expect(project.tools, isNull);
      expect(project.supplies, isNull);
      expect(project.tips, isNull);
    });

    /// Tests that the Project.fromJson factory constructor throws an error when required fields are missing.
    ///
    /// This test provides a JSON object missing required fields, such as the name of the project.
    /// It verifies that the constructor throws a TypeError, indicating that required fields must be
    /// present for the Project object to be instantiated correctly.
    test('should throw an error when required fields are missing', () {
      final JSONObject json = {
        '@context': 'https://schema.org',
        '@type': 'HowTo',
        'description': 'A project guide to help you build a simple mobile application from scratch.',
        'step': [
          {
            '@type': 'HowToStep',
            'name': 'Setup Development Environment',
            'description': 'Install Flutter and set up your IDE.',
            'itemListElement': [
              {
                '@type': 'HowToDirection',
                'text': 'Install Flutter and set up your IDE.',
              },
            ],
          },
        ],
      };

      expect(() => Project.fromJson(json), throwsA(isA<TypeError>()));
    });

    /// Tests that the Project.fromJson factory constructor correctly handles empty lists for fields.
    ///
    /// This test provides a JSON object with empty arrays for fields like steps, tools, supplies, and tips.
    /// It verifies that the Project object is instantiated with empty lists, ensuring that the
    /// application can handle cases where no items are present without causing errors.
    test('should handle empty lists gracefully', () {
      final JSONObject json = {
        '@context': 'https://schema.org',
        '@type': 'HowTo',
        'name': 'Build a Simple Mobile App',
        'description': 'A project guide to help you build a simple mobile application from scratch.',
        'step': <HowToStep>[],
        'tool': <HowToTool>[],
        'supply': <HowToSupply>[],
        'tip': <HowToTip>[],
      };

      final Project project = Project.fromJson(json);

      expect(project.name, 'Build a Simple Mobile App');
      expect(project.description, 'A project guide to help you build a simple mobile application from scratch.');
      expect(project.steps, isEmpty);
      expect(project.tools, isEmpty);
      expect(project.supplies, isEmpty);
      expect(project.tips, isEmpty);
    });
  });
}
