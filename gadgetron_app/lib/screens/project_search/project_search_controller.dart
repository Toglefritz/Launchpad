import 'package:flutter/material.dart';
import 'package:gadgetron_app/screens/project_explore/project_explore_route.dart';
import 'package:gadgetron_app/screens/project_search/project_search_route.dart';
import 'package:gadgetron_app/screens/project_search/project_search_view.dart';
import 'package:gadgetron_app/services/firebase_auth/authentication_service.dart';

/// A controller for the [ProjectSearchRoute] widget.
class ProjectSearchController extends State<ProjectSearchRoute> {
  /// A controller for the text input field used by users to describe their project as a method of searching.
  final TextEditingController searchController = TextEditingController();

  /// Handles the user's request to log out of the app.
  Future<void> onLogout() async {
    await AuthenticationService.signOut();
  }

  /// Handles submission of a project description to kick off the search process.
  ///
  /// The search process itself, in terms of the submission of the user's prompt to the Gemini model, waiting for
  /// the model to return a result, and displaying the result to the user, is handled by the [ProjectExploreRoute].
  Future<void> onSearch() async {
   await Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: (context) => ProjectExploreRoute(
          projectDescription: searchController.text,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) => ProjectSearchView(this);
}
