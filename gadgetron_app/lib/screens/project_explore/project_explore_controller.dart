import 'package:firebase_vertexai/firebase_vertexai.dart';
import 'package:flutter/material.dart';
import 'package:gadgetron_app/screens/project_explore/project_explore_loading_view.dart';
import 'package:gadgetron_app/screens/project_explore/project_explore_route.dart';
import 'package:gadgetron_app/screens/project_explore/project_explore_view.dart';
import 'package:gadgetron_app/screens/project_search/project_search_route.dart';
import 'package:gadgetron_app/services/firebase_gemini/gemini_service.dart';

/// A controller for the [ProjectSearchRoute] widget.
class ProjectExploreController extends State<ProjectExploreRoute> {
  /// A response from the Gemini model to the user's project description. This response is represented using the
  /// [GenerateContentResponse] class.
  GenerateContentResponse? response;

  /// A controller for the [TextField] used to submit additional queries to the Gemini model.
  final TextEditingController exploreFieldController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // When the controller is initialized, the app should immediately submit the user's project description to the
    // Gemini model to obtain a response.
    _submitProjectDescription();
  }

  /// Submits the user's project description to the Gemini model to obtain a response.
  Future<void> _submitProjectDescription() async {
    // Obtain the project description provided by the user in the [ProjectSearchRoute].
    final String projectDescription = widget.projectDescription;

    // Submit the project description to the Gemini model to obtain a response.
    final GenerateContentResponse? response = await GeminiService.getResponse(projectDescription);

    // Update the state with the response from the Gemini model.
    setState(() {
      this.response = response;
    });
  }

  /// Handles submission of a query from the user to explore the results returned by the Gemini model.
  ///
  /// This query may request a variety of information, such as more details on a specific project, questions about a
  /// part of the results, a request for more results, or other requests.
  Future<void> onExplorationQuery() async {
    // TODO(Toglefritz): Implement this method.
  }

  @override
  Widget build(BuildContext context) {
    // If a response has not been received from the Gemini model, display a loading view.
    if (response == null) {
      return ProjectExploreLoadingView(this);
    }
    // Once a response is received, display the results.
    else {
      return ProjectExploreView(this);
    }
  }
}
