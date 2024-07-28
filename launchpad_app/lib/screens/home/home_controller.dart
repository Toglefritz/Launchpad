import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:launchpad_app/screens/home/home_route.dart';
import 'package:launchpad_app/screens/home/home_view.dart';
import 'package:launchpad_app/screens/project/project_route.dart';
import 'package:launchpad_app/screens/project_creation/project_creation_route.dart';
import 'package:launchpad_app/services/project/augmented_project.dart';
import 'package:launchpad_app/services/project/project_service.dart';
import 'package:launchpad_app/services/user/user_service.dart';

/// A controller for the [HomeRoute] widget.
class HomeController extends State<HomeRoute> {
  /// A list of the user's current projects.
  List<AugmentedProject>? projects;

  /// Determines if an error occurred while fetching the user's current projects.
  bool hasError = false;

  @override
  void initState() {
    _getCurrentProjects();

    super.initState();
  }

  /// Fetches the user's current projects.
  ///
  /// This route displays a list of the user's current projects. This method fetches the current projects using a
  /// two-step process:
  ///   1. Get a list of the user's project IDs. This list is stored in the user's file in the Firestore database.
  ///   2. For each project ID, fetch the project data from the Firestore database. The project data is stored in a
  ///      series of documents in the Firestore database.
  ///
  /// The method sets the [projects] property to the list of projects fetched from the Firestore database.
  Future<void> _getCurrentProjects() async {
    try {
      // Get the current user.
      final User user = FirebaseAuth.instance.currentUser!;

      // Get an App Check token.
      final String? appCheckToken = await FirebaseAppCheck.instance.getToken();

      // If an App Check token is not available, set the hasError property to true and return.
      if (appCheckToken == null) {
        debugPrint('App Check token is null');

        setState(() {
          hasError = true;
        });

        return;
      }

      // Get the user's project IDs.
      final UserService userService = UserService(user);
      final List<String> projectIds = await userService.getCurrentProjects(appCheckToken: appCheckToken);

      // Fetch the project data for each project ID.
      final ProjectService projectService = ProjectService(user);
      final List<AugmentedProject> projects = <AugmentedProject>[];

      for (final String projectId in projectIds) {
        final AugmentedProject project = await projectService.readProject(
          projectId: projectId,
          appCheckToken: appCheckToken,
        );
        projects.add(project);
      }

      // Set the projects property to the list of projects fetched from the Firestore database.
      setState(() {
        this.projects = projects;
      });
    } catch (e) {
      debugPrint('Fetching projects failed with exception, $e');

      // Set the hasError property to true.
      setState(() {
        hasError = true;
      });
    }
  }

  /// Handles the selection of a project from the user's list of in-progress projects.
  Future<void> onProjectSelected(AugmentedProject project) async {
    // Navigate to the ProjectRoute with the selected project.
    await Navigator.push(
      context,
      MaterialPageRoute<bool>(
        builder: (context) => ProjectRoute(
          project: project,
          isNewProject: false,
        ),
      ),
    );
  }

  /// Handles taps on the button used to start the new project flow.
  Future<void> onNewProject() async {
    await Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: (context) => const ProjectCreationRoute(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) => HomeView(this);
}
