import 'package:flutter/material.dart';
import 'package:launchpad_app/screens/project/project_controller.dart';
import 'package:launchpad_app/services/project/project.dart';

/// This route presents a learning guide and allows the user to progress through the guide.
///
/// This route represents the main part of a user's interaction with the app in most case, in terms of the amount of
/// time spent in the app and the number of interactions with the app. This route presents a learning guide to the
/// user, allowing them to progress through the guide by completing tasks, asking questions of the guide's AI mentor,
/// and engaging with the app's community features. As the user progresses through the guide, they will be able to
/// earn points and badges, and will be able to see their progress in the guide.
class ProjectRoute extends StatefulWidget {
  /// Creates an instance of the [ProjectRoute] widget.
  const ProjectRoute({
    required this.project,
    required this.isNewProject,
    super.key,
  });

  /// The finalized project data approved by the user, potentially after refinement.
  final Project project;

  /// Determines if the project is a new project versus one that has already been saved and that the user is
  /// continuing to work on.
  final bool isNewProject;

  @override
  State<ProjectRoute> createState() => ProjectController();
}
