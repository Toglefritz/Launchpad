import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_vertexai/firebase_vertexai.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:launchpad_app/components/custom_barrier/custom_modal_barrier.dart';
import 'package:launchpad_app/screens/home/home_route.dart';
import 'package:launchpad_app/screens/navigation_wrapper/navigation_wrapper_route.dart';
import 'package:launchpad_app/screens/project/components/achievement_dialog.dart';
import 'package:launchpad_app/screens/project/extensions/step_explore_extension.dart';
import 'package:launchpad_app/screens/project/model/query_response_pair.dart';
import 'package:launchpad_app/screens/project/project_loading_view.dart';
import 'package:launchpad_app/screens/project/project_route.dart';
import 'package:launchpad_app/screens/project/project_view.dart';
import 'package:launchpad_app/services/firebase_gemini/gemini_service.dart';
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

  /// A getter for the [HowToStep] instance that is currently active. Since the first page is a cover page, the first
  /// step is at index `currentPage - 1`.
  HowToStep? get currentStep => currentPage == 0 ? null : augmentedProject!.steps[currentPage - 1];

  /// A controller for the text input field used by users to describe their project as a method of searching.
  final TextEditingController queryController = TextEditingController();

  /// A Gemini chat session used to offer the ability for the user to ask questions about the project. This chat
  /// session maintains the history of the conversation between the user and the Gemini system. It is created when the
  /// user submits their first query about the project, and then persists as long as the user is engaged with the
  /// project.
  ChatSession? _chatSession;

  /// Determines if the app is currently awaiting a response from the Gemini system.
  bool isChatLoading = false;

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
      augmentedProject = widget.project as AugmentedProject;

      // Set the currently active step to the first step that is active.
      await _setCurrentStep();

      return;
    }

    // The project is not already augmented the project data with additional information.
    final AugmentedProject project = await AugmentedProject.fromProject(widget.project);

    // Set the currently active step to the first step that is active.
    await _setCurrentStep();

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

  /// Sets the currently active step in the project based on the first step that is marked active in the project data.
  ///
  /// This route will attempt to resume the project from where the user may have left off in a previous session. This
  /// route assumes that only one step within a project will be active at a time. It finds the first active step in the
  /// project data and sets it as the currently active step.
  ///
  /// However, if no steps are active, which should only be the case on the first time the user accesses the project
  /// after its creation, the first step in the project is set as the active step. Additionally, in this case, the app
  /// will set the first step as active in the Firestore database.
  Future<void> _setCurrentStep() async {
    // Find the first step that is active.
    final HowToStep? activeStep = augmentedProject?.steps.where((HowToStep step) => step.active ?? false).firstOrNull;

    // If no steps are active, set the first step as active.
    if (activeStep == null) {
      augmentedProject?.steps.first.active = true;

      // Get an App Check token to use for setting the active step.
      final String? appCheckToken = await FirebaseAppCheck.instance.getToken();
      if (appCheckToken == null || appCheckToken.isEmpty) {
        // TODO(Toglefritz): How to handle this error?
      } else {
        // Set the first step as active in the project data.
        await augmentedProject?.steps.first.setActive(
          user: FirebaseAuth.instance.currentUser!,
          appCheckToken: appCheckToken,
          projectId: augmentedProject!.id!,
        );
      }
    }
    // If there is an active step from a previous session, set the active page in the PageView widget to that step.
    else {
      // Get the index of the active step. Because a cover page is displayed first, the active step index is one more
      // than the index of the active step in the project data.
      final int activeStepIndex = augmentedProject!.steps.indexOf(activeStep) + 1;
      debugPrint('Setting current page to $activeStepIndex');
      currentPage = activeStepIndex;
      // After the build phase is complete, jump to the active step.
      WidgetsBinding.instance.addPostFrameCallback(
        (_) => pageController.jumpToPage(activeStepIndex),
      );
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
  ///
  /// Each time the page is changed, this method will set the active step to the first one with incomplete directions.
  /// This way, if the user leaves the project at any point, they will return to the first step they have not yet
  /// completed.
  void onPageChanged(int page) {
    setState(() {
      currentPage = page;
    });

    // Find the first step for which at least one direction is incomplete. If all directions are complete, the first
    // step will be set as active.
    final HowToStep incompleteStep = augmentedProject!.steps.firstWhere(
      (HowToStep step) => step.directions.any((HowToDirection direction) => !direction.isComplete),
      orElse: () => augmentedProject!.steps.first,
    );

    // Set the first incomplete step as active.
    _setActiveStep(incompleteStep);
  }

  /// Handles submission of a query about the project.
  ///
  /// When the user submits a query about the project, the query is sent to the Gemini system for processing. The user
  /// can ask questions about the project, and receive answers and guidance from Gemini.
  Future<void> onQuery(String? query) async {
    // Set the boolean flag to indicate that the app is currently awaiting a response from the Gemini system.
    setState(() {
      isChatLoading = true;

      // Clear the text field after the query has been submitted.
      queryController.clear();
    });

    // First, if the chat session does not already exist, start a new chat session.
    if (_chatSession == null) {
      try {
        _chatSession = await GeminiService.startProjectQueryChat(augmentedProject!.toJson());
      } catch (e) {
        debugPrint('Failed to start chat with Gemini: $e');

        // Show a SnackBar to the user to inform them of the error.
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context)!.errorChatStart),
          ),
        );

        return;
      }
    }

    // Send the user's query to the Gemini system, as part of the ongoing (or just-started) chat session.
    final Content content = Content.text(query ?? queryController.text);

    try {
      // Send the user's query to the Gemini system.
      final GenerateContentResponse response = await GeminiService.sendChatMessage(
        chat: _chatSession!,
        content: content,
      );

      // Get the text content of the response from Gemini.
      final String? responseText = response.text;

      // If the response is null, something has gone ary with the response from Gemini. Display a SnackBar to the user.
      if (responseText == null) {
        debugPrint('Received null response from Gemini');

        // Show a SnackBar to the user to inform them of the error.
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context)!.errorChatResponse),
          ),
        );

        // Return as there is nothing more to do.
        return;
      }
      // Otherwise, if a response was received, add the query/response pair to the list of query/response pairs.
      else {
        final QueryResponsePair queryResponsePair = QueryResponsePair(
          query: query ?? queryController.text,
          response: responseText,
        );

        // Add the query/response pair to the list of query/response pairs for the current step.
        currentStep?.conversation.add(queryResponsePair);
      }
    } catch (e) {
      debugPrint('Failed to send chat message to Gemini: $e');

      // Show a SnackBar to the user to inform them of the error.
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context)!.errorChatMessage),
        ),
      );
    }

    // Clear the loading state after the response has been received.
    setState(() {
      isChatLoading = false;
    });
  }

  /// Handles taps on the individual checkboxes for directions within the project steps.
  ///
  /// When the user taps on a checkbox, the direction is marked as complete or incomplete. When an individual direction
  /// is marked as complete, several actions are taken:
  /// 1. The direction is visually marked as complete.
  /// 2. The direction is marked as complete in the project data.
  /// 3. An API call is made to the Firebase backend to mark the direction as complete.
  /// 4. If all directions in the current step are now complete, the step itself is considered to be complete. When a
  ///    step is completed for which there is a linked achievement, a dialog is displayed to the user to inform them of
  ///    the achievement.
  /// 5. When an achievement is awarded, an API call is made to the Firebase backend to mark the achievement as awarded.
  /// 6. When the final direction in a step is completed, the app also sets the next step as the currently active step,
  ///    assuming the current step is not the last one.
  Future<void> onDirectionCompleted(HowToDirection direction) async {
    setState(() {
      direction.isComplete = !direction.isComplete;
    });

    try {
      await _setDirectionComplete(direction);
    } catch (e) {
      debugPrint('Failed to mark direction as complete: $e');

      // Show a SnackBar to the user to inform them of the error.
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context)!.directionCompletionError),
        ),
      );

      // Revert the direction to its previous state.
      setState(() {
        direction.isComplete = !direction.isComplete;
      });

      return;
    }

    // Check if all directions are now complete.
    final HowToStep currentStep = augmentedProject!.steps[currentPage - 1];
    final bool allStepsComplete = currentStep.directions.every((direction) => direction.isComplete);

    // If there are still steps remaining to be completed, there is nothing left to do in this method.
    if (!allStepsComplete) {
      return;
    }

    // Get the achievement for completing the step. If there is no achievement, the value will be null.
    final Achievement? achievement =
        augmentedProject?.achievements.where((achievement) => achievement.id == currentStep.id).firstOrNull;

    // If no achievement is available, or if the achievement is already completed simply move to the next step.
    if (achievement == null || achievement.isComplete) {
      // Proceed to the next step if all directions are complete.
      onNextPage();
    }
    // Otherwise, if the user is due an achievement, present the achievement dialog.
    else {
      try {
        await _presentAchievementDialog(achievement);
      } catch (e) {
        debugPrint('Failed to present achievement dialog: $e');

        // No-op
        // The user can continue with the project, but they unfortunately will not be informed of the achievement.
      }

      // After the dialog is closed, navigate to the next step in the project.
      onNextPage();
    }
  }

  /// Sets the provided [HowToStep] as active in the Firestore backend.
  ///
  /// This method is called when the user navigates to a new step in the project. The step is set as active in the
  /// Firestore backend so that the user can resume the project from where they left off in a previous session. The
  /// active step is always the first one with at least one incomplete direction.
  Future<void> _setActiveStep(HowToStep activeStep) async {
    // Get an App Check token to use for setting the active step.
    final String? appCheckToken = await FirebaseAppCheck.instance.getToken();
    if (appCheckToken == null || appCheckToken.isEmpty) {
      // TODO(Toglefritz): Handle error.
      return;
    }

    // Set the current step as active in the Firestore backend.
    await activeStep.setActive(
      user: FirebaseAuth.instance.currentUser!,
      appCheckToken: appCheckToken,
      projectId: augmentedProject!.id!,
    );
  }

  /// Sets the provided [HowToDirection] as complete in the Firestore backend.
  Future<void> _setDirectionComplete(HowToDirection direction) async {
    // Get an App Check token to use for marking the direction as complete.
    final String? appCheckToken = await FirebaseAppCheck.instance.getToken();
    if (appCheckToken == null || appCheckToken.isEmpty) {
      // TODO(Toglefritz): How should this error be handled? The user can keep going with the project but this completed step will not be saved.
      return;
    } else {
      // Mark the direction as complete in the project data.
      await direction.markAsComplete(
        user: FirebaseAuth.instance.currentUser!,
        appCheckToken: appCheckToken,
        projectId: augmentedProject!.id!,
      );
    }
  }

  /// Presents a dialog when the user completes a step in the project and earns an achievement.
  Future<void> _presentAchievementDialog(Achievement achievement) async {
    // Get an App Check token to use for deleting the project.
    final String? appCheckToken = await FirebaseAppCheck.instance.getToken();
    if (appCheckToken == null || appCheckToken.isEmpty) {
      // TODO(Toglefritz): Handle error.
      return;
    }

    // If an achievement is available, show a dialog to the user.
    achievement.isComplete = true;

    // Show the achievement dialog.
    if (!mounted) return;
    await showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AchievementDialog(
          achievement: achievement,
        );
      },
    );

    // Mark the achievement as complete in the project data.
    await achievement.markAsComplete(
      user: FirebaseAuth.instance.currentUser!,
      appCheckToken: appCheckToken,
      projectId: augmentedProject!.id!,
    );
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
          return;
        }

        // Delete the project from the user's account.
        final ProjectService projectService = ProjectService(FirebaseAuth.instance.currentUser!);
        await projectService.deleteProject(
          projectId: augmentedProject!.id!,
          appCheckToken: appCheckToken,
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
