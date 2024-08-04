import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:launchpad_app/components/custom_barrier/custom_modal_barrier.dart';
import 'package:launchpad_app/screens/home/home_route.dart';
import 'package:launchpad_app/screens/navigation_wrapper/navigation_wrapper_route.dart';
import 'package:launchpad_app/screens/project/components/achievement_dialog.dart';
import 'package:launchpad_app/screens/project/project_loading_view.dart';
import 'package:launchpad_app/screens/project/project_route.dart';
import 'package:launchpad_app/screens/project/project_view.dart';
import 'package:launchpad_app/services/project/augmented_project.dart';
import 'package:launchpad_app/services/project/models/achievement.dart';
import 'package:launchpad_app/services/project/models/how_to_direction.dart';
import 'package:launchpad_app/services/project/models/how_to_step.dart';
import 'package:launchpad_app/services/project/project.dart';
import 'package:launchpad_app/services/project/project_service.dart';

/// A controller for the [ProjectRoute] widget.
class ProjectController extends State<ProjectRoute> {
  /// The augmented project data presented by this route. This data is assembled from the project data provided by the
  /// user and additional information from other sources.
  AugmentedProject? augmentedProject;

  /// A controller for the [PageView] widget used to display the project steps.
  final PageController pageController = PageController();

  /// The index of the currently active page.
  int currentPage = 0;

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
  /// If the project data is not already augmented, this method augments the project data with additional information.
  ///
  /// When this route is accessed for a new project, the [Project] instance delivered to this route contains text
  /// content for the project. This function augments this data with the following additional information that is,
  /// broadly speaking, stitched together from a variety of sources:
  ///
  ///   - An image for the project.
  ///   - Links to online sources where project tools and materials can be purchased.
  Future<void> _assembleProjectData() async {
    // If the project data is already augmented, there is no need to augment it again.
    if (widget.project is AugmentedProject) {
      setState(() {
        augmentedProject = widget.project as AugmentedProject;
      });

      return;
    }

    // The project is not already augmented the project data with additional information.
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

  /// Handles taps on the "back" button in the app bar.
  ///
  /// Because a new project may have been saved to the user's account by this route, or the contents of an existing
  /// project may have been updated, the list of projects displayed to the user will need to be updated. This is
  /// accomplished by navigating back to the [NavigationWrapperRoute], which will display the [HomeRoute] initially,
  /// and removing all other routes from the navigation stack, including the original version of the [HomeRoute].
  void onBack() {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute<void>(builder: (context) => const NavigationWrapperRoute()),
      (route) => false,
    );
  }

  /// Handles taps on interface elements that move the user to the next step in the project. Several elements in the
  /// interface can trigger this action.
  void onNextPage() {
    pageController.nextPage(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeInOut,
    );

    setState(() {
      currentPage = pageController.page!.round();
    });
  }

  /// Handles changes in the active page of the [PageView] widget.
  void onPageChanged(int page) {
    setState(() {
      currentPage = page;
    });
  }

  /// Handles submission of a query about the project.
  ///
  // TODO(Toglefritz): Implement this method and expand documentation.
  Future<void> onQuery() async {}

  /// Handles taps on the individual checkboxes for directions within the project steps.
  ///
  /// When the user taps on a checkbox, the direction is marked as complete or incomplete. When an individual direction
  /// is marked as complete, several actions are taken:
  /// 1. The direction is visually marked as complete.
  /// 2. The direction is marked as complete in the project data.
  /// 3. An API call is made to the Firebase backend to mark the direction as complete.
  /// 4. If all directions in the current step are now complete, the step itself is considered to be complete. WHen a
  ///    step is completed for which there is a linked achievement, a dialog is displayed to the user to inform them of
  ///    the achievement.
  /// 5. When an achievement is awarded, an API call is made to the Firebase backend to mark the achievement as awarded.
  Future<void> onDirectionCompleted(HowToDirection direction) async {
    setState(() {
      direction.isComplete = !direction.isComplete;
    });

    // Get an App Check token to use for marking the direction as complete.
    final String? appCheckToken = await FirebaseAppCheck.instance.getToken();
    if (appCheckToken == null || appCheckToken.isEmpty) {
      // TODO(Toglefritz): How should this error be handled? The user can keep going with the project but this completed step will not be saved.
    } else {
      await direction.markAsComplete(
        user: FirebaseAuth.instance.currentUser!,
        appCheckToken: appCheckToken,
        projectId: augmentedProject!.id!,
      );
    }

    // Check if all directions are now complete.
    final HowToStep currentStep = augmentedProject!.steps[currentPage - 1];
    final bool allStepsComplete = currentStep.directions.every((direction) => direction.isComplete);

    // Get the achievement for completing the step. If there is no achievement, the value will be null.
    final Achievement? achievement =
        augmentedProject?.achievements.where((achievement) => achievement.id == currentStep.id).firstOrNull;

    // If no achievement is available, there is nothing left to do in this method.
    if (achievement == null) {
      return;
    } else {
      // If an achievement is available, show a dialog to the user.
      if (allStepsComplete && mounted) {
        await showDialog<void>(
          context: context,
          builder: (BuildContext context) {
            return AchievementDialog(
              achievement: achievement,
            );
          },
        );

        // After the dialog is closed, navigate to the next step in the project.
        onNextPage();
      }
    }
  }

  /// Handles requests by the user to delete the current project.
  ///
  /// When the user selects the option to delete the project from the menu in the app bar, a dialog is displayed to
  /// confirm the user's intent to delete the project. If the user confirms the deletion, the project is deleted from
  /// the user's account and the user is navigated back to the [HomeRoute].
  ///
  /// It is assumed that the project has an ID when this method is called.
  Future<void> onDeleteProject() async {
    // Display a dialog to confirm the user's intent to delete the project.
    final bool? deleteConfirmed = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return CustomModalBarrier(
          child: AlertDialog(
            title: Text(AppLocalizations.of(context)!.deleteProjectDialogTitle),
            content: Text(AppLocalizations.of(context)!.deleteProjectDialogConfirmation),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text(AppLocalizations.of(context)!.cancel),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: Text(AppLocalizations.of(context)!.delete),
              ),
            ],
          ),
        );
      },
    );

    // If the user confirms the deletion, delete the project from the user's account.
    if (deleteConfirmed ?? false) {
      try {
        // Get an App Check token to use for deleting the project.
        final String? appCheckToken = await FirebaseAppCheck.instance.getToken();
        if (appCheckToken == null || appCheckToken.isEmpty) {
          // TODO(Toglefritz): Handle error.
        }

        // Delete the project from the user's account.
        final ProjectService projectService = ProjectService(FirebaseAuth.instance.currentUser!);
        await projectService.deleteProject(
          projectId: augmentedProject!.id!,
          appCheckToken: appCheckToken!,
        );

        // Navigate back to the home route.
        onBack();
      } catch (e) {
        debugPrint('Failed to delete project from user account: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) => augmentedProject == null ? ProjectLoadingView(this) : ProjectView(this);
}
