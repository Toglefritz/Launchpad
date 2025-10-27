// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get accountLabel => 'Account';

  @override
  String get achievementCloseButton => 'Carry on';

  @override
  String get achievementsTitle => 'Achievements';

  @override
  String get and => ' and ';

  @override
  String get appName => 'Launchpad';

  @override
  String get authenticationButtonText => 'Make it so';

  @override
  String get cancel => 'Cancel';

  @override
  String get changeProfilePicture => 'Change Picture';

  @override
  String get chatInputHint => 'Have a question?';

  @override
  String get continueWithGoogle => 'Continue with Google';

  @override
  String get conversationTitle => 'Exploration';

  @override
  String get createAccount => 'Create account';

  @override
  String get errorChatMessage =>
      'An error occurred while sending your question. Please try again.';

  @override
  String get errorChatResponse =>
      'An error occurred while retrieving the response. Please try again.';

  @override
  String get errorChatStart =>
      'Project exploration could not be started. Please try again.';

  @override
  String get errorOnboardingInvalidEmail =>
      'This email address looks like it isn\'t one.';

  @override
  String get errorOnboardingEmailEmpty => 'This probably shouldn\'t be empty.';

  @override
  String get errorOnboardingEmailInUse =>
      'This email address is already in use. Use the toggle above to log in instead.';

  @override
  String get errorOnboardingFailedToAuthenticate =>
      'An unknown error occurred. Not good. Please try again a bit later as this is probably our fault.';

  @override
  String get errorOnboardingPasswordTooShort =>
      'Password must be at least eight characters long.';

  @override
  String get errorOnboardingPasswordEmpty => 'Please enter your password.';

  @override
  String get errorOnboardingUserNotFound =>
      'This email address isn\'t associated with an account. Use the toggle above to create an account instead.';

  @override
  String get errorOnboardingWeakPassword =>
      'The password provided is too weak.';

  @override
  String get errorOnboardingWrongPassword =>
      'The password provided is incorrect.';

  @override
  String get delete => 'Delete';

  @override
  String get deleteProject => 'Delete Project';

  @override
  String get deleteProjectDialogConfirmation =>
      'Are you sure you want to delete this project?';

  @override
  String get deleteProjectDialogTitle => 'Delete Project?';

  @override
  String get directionCompletionError =>
      'The step could not be marked as complete. Please try again.';

  @override
  String get directions => 'Directions';

  @override
  String get getStarted => 'Get Started';

  @override
  String get homeLabel => 'Home';

  @override
  String get homeTitle => 'Launch';

  @override
  String get loading => 'Loading...';

  @override
  String get loadingResults => 'Loading project...';

  @override
  String get login => 'Login';

  @override
  String get logout => 'Logout';

  @override
  String get newProject => 'New Project';

  @override
  String get noProjectsFound => 'Ready to create your first project?';

  @override
  String get onboardingDescription => 'Ready to learn something new?';

  @override
  String get onboardingLegalPrompt1 => 'Take a gander at the ';

  @override
  String get onboardingLegalPrompt2 => ' before using this app.';

  @override
  String get onboardingTitle => 'Welcome to';

  @override
  String get passwordLabel => 'Password';

  @override
  String get preparingProject => 'Preparing project...';

  @override
  String get profilePicture => 'Profile Picture';

  @override
  String get projectDraftLoadingDescription =>
      'Building your project draft will take just a moment.';

  @override
  String get projectLoadingDescription =>
      'Getting your project ready will take just a moment.';

  @override
  String get privacyPolicy => 'privacy policy';

  @override
  String promptStep1(String userDescription) {
    return 'Generate a comprehensive project guide for $userDescription that follows the schema.org HowTo schema. The guide should include detailed steps, necessary tools and materials, and relevant tips and challenges to ensure the user explores every aspect of the skill.';
  }

  @override
  String get projectApprovalButton => 'Looks good!';

  @override
  String get projectExploreTitle => 'Explore';

  @override
  String get projectRefinementRequest =>
      'Please review the initial project guide and indicate if any steps need more detail or if additional aspects should be included. Specific feedback will help improve the guide.';

  @override
  String get projectRefinementTitle => 'Refine';

  @override
  String get projectsTitle => 'Projects';

  @override
  String get projectSearchFieldTitle => 'What would you like to learn?';

  @override
  String get projectsRetrievalError => 'Project retrieval failed';

  @override
  String get searchButton => 'Engage';

  @override
  String get selectAnImage => 'Select an Image';

  @override
  String get steps => 'Steps';

  @override
  String get supplies => 'Supplies';

  @override
  String get termsOfService => 'terms of service';

  @override
  String get tips => 'Tips';

  @override
  String get tools => 'Tools';

  @override
  String get updatingProject => 'Updating project...';

  @override
  String get usernameLabel => 'Username';
}
