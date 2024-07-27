import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:launchpad_app/screens/project/project_loading_view.dart';
import 'package:launchpad_app/screens/project/project_route.dart';
import 'package:launchpad_app/screens/project/project_view.dart';
import 'package:launchpad_app/services/project/augmented_project.dart';
import 'package:launchpad_app/services/project/project.dart';
import 'package:launchpad_app/services/project/project_service.dart';

/// A controller for the [ProjectRoute] widget.
class ProjectController extends State<ProjectRoute> {
  /// The augmented project data presented by this route. This data is assembled from the project data provided by the
  /// user and additional information from other sources.
  AugmentedProject? augmentedProject;

  /// A controller for the text input field used by users to describe their project as a method of searching.
  final TextEditingController queryController = TextEditingController();

  @override
  void initState() {
    // Start assembling the project data when the controller is initialized.
    _assembleProjectData();

    super.initState();
  }

  /// Assembles the project data.
  ///
  /// The [Project] instance delivered to this route contains text content for the project. This function augments
  /// this data with the following additional information that is, broadly speaking, stitched together from a variety
  /// of sources:
  ///   - An image for the project.
  ///   - Links to online sources where project tools and materials can be purchased.
  Future<void> _assembleProjectData() async {
    // Augment the project data with additional information.
    final AugmentedProject project = await AugmentedProject.fromProject(widget.project);

    // Notify the route that the project data has been assembled.
    setState(() {
      augmentedProject = project;
    });

    try {
      // Once the project data has been assembled, save the project to the user's account. This enables the user to
      // access the project later. At this stage, it is assumed that the user is authenticated.

      // Get an App Check token to use for saving the project.
      final String? appCheckToken = await FirebaseAppCheck.instance.getToken();
      if (appCheckToken == null || appCheckToken.isEmpty) {
        // TODO(Toglefritz): Handle error.
      }

      // Save the project to the user's account.
      final ProjectService projectService = ProjectService(FirebaseAuth.instance.currentUser!);
      await projectService.createProject(
        augmentedProject: augmentedProject!,
        appCheckToken: appCheckToken!,
      );
    } catch (e) {
      debugPrint('Failed to save project to user account: $e');

      // TODO(Toglefritz): Handle error. Perhaps show a SnackBar to the user. How does the user try to save again?
    }
  }

  /// Handles submission of a query about the project.
  ///
  // TODO(Toglefritz): Implement this method and expand documentation.
  Future<void> onQuery() async {}

  @override
  Widget build(BuildContext context) => augmentedProject == null ? ProjectLoadingView(this) : ProjectView(this);
}
