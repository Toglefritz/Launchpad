import 'dart:math';

import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:launchpad_app/screens/home/home_route.dart';
import 'package:launchpad_app/screens/home/home_view.dart';
import 'package:launchpad_app/screens/project/project_route.dart';
import 'package:launchpad_app/screens/project_creation/project_creation_route.dart';
import 'package:launchpad_app/services/project/augmented_project.dart';
import 'package:launchpad_app/services/project/models/earned_achievement.dart';
import 'package:launchpad_app/services/project/project_service.dart';
import 'package:launchpad_app/services/user/user_service.dart';

/// A controller for the [HomeRoute] widget.
class HomeController extends State<HomeRoute> {
  /// A list of the user's current projects.
  List<AugmentedProject>? projects;

  /// A list of achievements the user has earned. This list will be sorted in chronological order, with the most recent
  /// achievement first.
  List<EarnedAchievement>? earnedAchievements;

  /// Determines if an error occurred while fetching the user's current projects.
  bool hasError = false;

  @override
  void initState() {
    // Fetch the user's current projects.
    _getCurrentProjects();

    // Get the user's earned achievements.
    _getEarnedAchievements();

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

  /// Fetches the user's earned achievements.
  ///
  /// This method fetches the user's earned achievements from the Firestore database. The achievements are stored in a
  /// series of JSON objects in the user's file in the Firestore database. The method sets the [earnedAchievements]
  /// property to the list of achievements fetched from the Firestore database.
  Future<void> _getEarnedAchievements() {
    // Get the current user.
    final User user = FirebaseAuth.instance.currentUser!;

    // Get an App Check token.
    return FirebaseAppCheck.instance.getToken().then((String? appCheckToken) async {
      // If an App Check token is not available, set the hasError property to true and return.
      if (appCheckToken == null) {
        debugPrint('App Check token is null');

        setState(() {
          hasError = true;
        });

        return;
      }

      // Get the user's earned achievements.
      final UserService userService = UserService(user);
      final List<EarnedAchievement> earnedAchievements = await userService.getEarnedAchievements(
        appCheckToken: appCheckToken,
      );

      // Sort the achievements in chronological order, with the most recent achievement first.
      earnedAchievements.sort((EarnedAchievement a, EarnedAchievement b) => b.date.compareTo(a.date));

      // Set the earnedAchievements property to the list of achievements fetched from the Firestore database.
      setState(() {
        this.earnedAchievements = earnedAchievements;
      });
    }).catchError((Object e) {
      debugPrint('Fetching earned achievements failed with exception, $e');

      // No-op
      // Since the achievements could not be retrieved, the user will not see any achievements.
    });
  }

  /// Returns a random [Icon] to be used as a decoration for the widgets that display achievements earned by the
  /// user.
  Icon getAchievementIcon() {
    // A list of icons that can be used to decorate the achievements.
    final List<Icon> icons = <Icon>[
      const Icon(Icons.star_border),
      const Icon(Icons.star),
      const Icon(Icons.emoji_events_outlined),
      const Icon(Icons.emoji_events),
      const Icon(Icons.military_tech_outlined),
      const Icon(Icons.military_tech),
      const Icon(Icons.verified_outlined),
      const Icon(Icons.verified),
      const Icon(Icons.flag_outlined),
      const Icon(Icons.stars),
    ];

    // Generate a random index to select an icon from the list of icons.
    final int index = Random().nextInt(icons.length);

    return icons[index];
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
