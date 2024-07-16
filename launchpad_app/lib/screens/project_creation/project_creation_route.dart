import 'package:flutter/material.dart';
import 'package:launchpad_app/screens/home/home_route.dart';
import 'package:launchpad_app/screens/project_creation/project_creation_controller.dart';

/// This route allows the user to create a new learning project.
///
/// This route is presented to the user when they tap the "New Project" button on the [HomeRoute]. This route allows the
/// user to describe their project in a text field and submit the description to the Gemini model for processing. The
/// Gemini model will create a draft of a project plan based on the user's description, for which the user can then
/// provide feedback and make changes. Once the user is satisfied with the project plan, they can submit the plan to
/// the application to create a new project.
class ProjectCreationRoute extends StatefulWidget {
  /// Creates an instance of the [ProjectCreationRoute] widget.
  const ProjectCreationRoute({super.key});

  @override
  State<ProjectCreationRoute> createState() => ProjectCreationController();
}
