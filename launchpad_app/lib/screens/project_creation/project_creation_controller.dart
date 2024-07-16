import 'package:flutter/material.dart';
import 'package:launchpad_app/screens/project_creation/project_creation_route.dart';
import 'package:launchpad_app/screens/project_creation/project_creation_view.dart';
import 'package:launchpad_app/screens/project_refinement/project_refinement_route.dart';
import 'package:launchpad_app/services/firebase_auth/authentication_service.dart';

/// A controller for the [ProjectCreationRoute] widget.
class ProjectCreationController extends State<ProjectCreationRoute> {
  /// A controller for the text input field used by users to describe their project as a method of searching.
  final TextEditingController searchController = TextEditingController();

  /// Handles the user's request to log out of the app.
  Future<void> onLogout() async {
    await AuthenticationService.signOut();
  }

  /// Handles submission of a project description to kick off the search process.
  ///
  /// The search process itself, in terms of the submission of the user's prompt to the Gemini model, waiting for
  /// the model to return a result, and displaying the result to the user, is handled by the [ProjectRefinementRoute].
  Future<void> onSearch() async {
   await Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: (context) => ProjectRefinementRoute(
          projectDescription: searchController.text,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) => ProjectCreationView(this);
}
