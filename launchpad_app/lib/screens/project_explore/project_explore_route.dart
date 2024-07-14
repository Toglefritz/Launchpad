import 'package:flutter/material.dart';
import 'package:launchpad_app/screens/project_explore/project_explore_controller.dart';
import 'package:launchpad_app/screens/project_search/project_search_route.dart';

/// A route displaying the results returned by the Gemini model in response to a user's project description. This
/// route offers a "chat" interface where the user can interact with the Gemini model to refine their project
/// description, ask questions, and receive more results.
///
/// This route is responsible for displaying the results returned by the Gemini model in response to a user's project
/// description. The user can interact with the Gemini model to refine their project description, ask questions, and
/// receive more results. The route is implemented as a chat interface where the user can input text and receive
/// responses from the Gemini model.
class ProjectExploreRoute extends StatefulWidget {
  /// Creates an instance of the [ProjectExploreRoute] widget.
  const ProjectExploreRoute({
    required this.projectDescription,
    super.key,
  });

  /// The project description provided by the user in the [ProjectSearchRoute].
  final String projectDescription;

  @override
  State<ProjectExploreRoute> createState() => ProjectExploreController();
}
