import 'package:flutter/material.dart';
import 'package:launchpad_app/screens/project/project_loading_view.dart';
import 'package:launchpad_app/screens/project/project_route.dart';
import 'package:launchpad_app/screens/project/project_view.dart';
import 'package:launchpad_app/services/project/augmented_project.dart';
import 'package:launchpad_app/services/project/project.dart';

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
  }

  /// Handles submission of a query about the project.
  ///
  // TODO(Toglefritz): Implement this method and expand documentation.
  Future<void> onQuery() async {}

  @override
  Widget build(BuildContext context) => augmentedProject == null ? ProjectLoadingView(this) : ProjectView(this);
}
