import 'package:flutter/material.dart';
import 'package:launchpad_app/screens/project_search/project_search_controller.dart';

/// A route enabling the user to "search" for resources by describing a project.
///
/// One of the key tools provided by the Launchpad app is the ability to search for resources by describing a project.
/// This route contains a text input field in which the user can enter a project description. From this description,
/// the app will generate a list of resources that match the project description. The resources may include product
/// recommendations, educational resources, explanations of key concepts, feedback, and more.
class ProjectSearchRoute extends StatefulWidget {
  /// Creates an instance of the [ProjectSearchRoute] widget.
  const ProjectSearchRoute({super.key});

  @override
  State<ProjectSearchRoute> createState() => ProjectSearchController();
}
