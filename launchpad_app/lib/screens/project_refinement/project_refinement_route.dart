import 'package:flutter/material.dart';
import 'package:launchpad_app/screens/project_creation/project_creation_route.dart';
import 'package:launchpad_app/screens/project_refinement/project_refinement_controller.dart';

/// This route displays the initial results returned by the Gemini model in response to a user's project description.
/// The user is invited to review the initial results and provide feedback to the model to refine the results. The
/// user is able to continue this refinement process until they are satisfied with the results. Then they are able
/// to move on to the next step.
class ProjectRefinementRoute extends StatefulWidget {
  /// Creates an instance of the [ProjectRefinementRoute] widget.
  const ProjectRefinementRoute({
    required this.projectDescription,
    super.key,
  });

  /// The project description provided by the user in the [ProjectCreationRoute].
  final String projectDescription;

  @override
  State<ProjectRefinementRoute> createState() => ProjectRefinementController();
}
