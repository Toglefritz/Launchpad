import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[Locale('en')];

  /// No description provided for @accountLabel.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get accountLabel;

  /// Text for the button that allows the user to close the achievement dialog
  ///
  /// In en, this message translates to:
  /// **'Carry on'**
  String get achievementCloseButton;

  /// Title for the achievements section of the home page
  ///
  /// In en, this message translates to:
  /// **'Achievements'**
  String get achievementsTitle;

  /// Text used to separate two items in a list.
  ///
  /// In en, this message translates to:
  /// **' and '**
  String get and;

  /// Name of the app
  ///
  /// In en, this message translates to:
  /// **'Launchpad'**
  String get appName;

  /// Text for the authentication button
  ///
  /// In en, this message translates to:
  /// **'Make it so'**
  String get authenticationButtonText;

  /// Text for a cancel button
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// Text for the button that allows the user to change their profile picture.
  ///
  /// In en, this message translates to:
  /// **'Change Picture'**
  String get changeProfilePicture;

  /// Hint text for the chat input field
  ///
  /// In en, this message translates to:
  /// **'Have a question?'**
  String get chatInputHint;

  /// Text for the Google authentication button per Google identity guidelines
  ///
  /// In en, this message translates to:
  /// **'Continue with Google'**
  String get continueWithGoogle;

  /// Title for the FAQ-style chat interface
  ///
  /// In en, this message translates to:
  /// **'Exploration'**
  String get conversationTitle;

  /// Text for the ChoiceChip used by the user to indicate that they want to create an account
  ///
  /// In en, this message translates to:
  /// **'Create account'**
  String get createAccount;

  /// Error message for when the app fails to send a chat message.
  ///
  /// In en, this message translates to:
  /// **'An error occurred while sending your question. Please try again.'**
  String get errorChatMessage;

  /// Error message for when the app fails to retrieve a chat response.
  ///
  /// In en, this message translates to:
  /// **'An error occurred while retrieving the response. Please try again.'**
  String get errorChatResponse;

  /// Error message for when the app fails to start a chat.
  ///
  /// In en, this message translates to:
  /// **'Project exploration could not be started. Please try again.'**
  String get errorChatStart;

  /// Error message for when the user enters an invalid email address.
  ///
  /// In en, this message translates to:
  /// **'This email address looks like it isn\'t one.'**
  String get errorOnboardingInvalidEmail;

  /// Error message for when the user tries to submit the onboarding form without entering an email address.
  ///
  /// In en, this message translates to:
  /// **'This probably shouldn\'t be empty.'**
  String get errorOnboardingEmailEmpty;

  /// Error message for when the user tries to create an account with an email address that is already in use.
  ///
  /// In en, this message translates to:
  /// **'This email address is already in use. Use the toggle above to log in instead.'**
  String get errorOnboardingEmailInUse;

  /// Error message for when the user fails to authenticate during onboarding.
  ///
  /// In en, this message translates to:
  /// **'An unknown error occurred. Not good. Please try again a bit later as this is probably our fault.'**
  String get errorOnboardingFailedToAuthenticate;

  /// Error message for when the user enters a password that is too short.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least eight characters long.'**
  String get errorOnboardingPasswordTooShort;

  /// Error message for when the user tries to submit the onboarding form without entering a password.
  ///
  /// In en, this message translates to:
  /// **'Please enter your password.'**
  String get errorOnboardingPasswordEmpty;

  /// Error message for when the user tries to log in with an email address that is not associated with an account.
  ///
  /// In en, this message translates to:
  /// **'This email address isn\'t associated with an account. Use the toggle above to create an account instead.'**
  String get errorOnboardingUserNotFound;

  /// Error message for when the user enters a password that is too weak.
  ///
  /// In en, this message translates to:
  /// **'The password provided is too weak.'**
  String get errorOnboardingWeakPassword;

  /// Error message for when the user enters an incorrect password.
  ///
  /// In en, this message translates to:
  /// **'The password provided is incorrect.'**
  String get errorOnboardingWrongPassword;

  /// Text for a delete button
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// Text for the button that allows the user to delete a project.
  ///
  /// In en, this message translates to:
  /// **'Delete Project'**
  String get deleteProject;

  /// Confirmation message for the dialog that asks the user if they want to delete a project.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this project?'**
  String get deleteProjectDialogConfirmation;

  /// Title for the dialog that asks the user if they want to delete a project.
  ///
  /// In en, this message translates to:
  /// **'Delete Project?'**
  String get deleteProjectDialogTitle;

  /// Error message for when the app fails to mark a step as complete.
  ///
  /// In en, this message translates to:
  /// **'The step could not be marked as complete. Please try again.'**
  String get directionCompletionError;

  /// Text for the directions sections of the project guides
  ///
  /// In en, this message translates to:
  /// **'Directions'**
  String get directions;

  /// Text for the get started button
  ///
  /// In en, this message translates to:
  /// **'Get Started'**
  String get getStarted;

  /// Label for the home item in the bottom navigation bar
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get homeLabel;

  /// Title for the home page
  ///
  /// In en, this message translates to:
  /// **'Launch'**
  String get homeTitle;

  /// Text displayed while the app is loading a project.
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get loading;

  /// Text displayed while the app is loading search results.
  ///
  /// In en, this message translates to:
  /// **'Loading project...'**
  String get loadingResults;

  /// Text for the ChoiceChip used by the user to indicate that they want to login to the app
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// Text for the logout button
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// Text for the button that allows the user to create a new project.
  ///
  /// In en, this message translates to:
  /// **'New Project'**
  String get newProject;

  /// Text inviting the user to create their first project
  ///
  /// In en, this message translates to:
  /// **'Ready to create your first project?'**
  String get noProjectsFound;

  /// Description for the onboarding page
  ///
  /// In en, this message translates to:
  /// **'Ready to learn something new?'**
  String get onboardingDescription;

  /// The first part of a prompt asking the user to review the app's legal agreements before using the app
  ///
  /// In en, this message translates to:
  /// **'Take a gander at the '**
  String get onboardingLegalPrompt1;

  /// The second part of a prompt asking the user to review the app's legal agreements before using the app
  ///
  /// In en, this message translates to:
  /// **' before using this app.'**
  String get onboardingLegalPrompt2;

  /// Title for the onboarding page
  ///
  /// In en, this message translates to:
  /// **'Welcome to'**
  String get onboardingTitle;

  /// Label for the password field
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get passwordLabel;

  /// Text displayed while the app is preparing a project.
  ///
  /// In en, this message translates to:
  /// **'Preparing project...'**
  String get preparingProject;

  /// Label for the profile picture field
  ///
  /// In en, this message translates to:
  /// **'Profile Picture'**
  String get profilePicture;

  /// Description for the project draft loading page
  ///
  /// In en, this message translates to:
  /// **'Building your project draft will take just a moment.'**
  String get projectDraftLoadingDescription;

  /// Description for the project loading page
  ///
  /// In en, this message translates to:
  /// **'Getting your project ready will take just a moment.'**
  String get projectLoadingDescription;

  /// Text for a button that allows the user to view the privacy policy.
  ///
  /// In en, this message translates to:
  /// **'privacy policy'**
  String get privacyPolicy;

  /// Gemini prompt for the first step in the project creation flow.
  ///
  /// In en, this message translates to:
  /// **'Generate a comprehensive project guide for {userDescription} that follows the schema.org HowTo schema. The guide should include detailed steps, necessary tools and materials, and relevant tips and challenges to ensure the user explores every aspect of the skill.'**
  String promptStep1(String userDescription);

  /// Text for the button that allows the user to approve the project guide draft.
  ///
  /// In en, this message translates to:
  /// **'Looks good!'**
  String get projectApprovalButton;

  /// Title for the project explore page
  ///
  /// In en, this message translates to:
  /// **'Explore'**
  String get projectExploreTitle;

  /// A request to the user to provide feedback on the project guide draft.
  ///
  /// In en, this message translates to:
  /// **'Please review the initial project guide and indicate if any steps need more detail or if additional aspects should be included. Specific feedback will help improve the guide.'**
  String get projectRefinementRequest;

  /// Title for the project refinement page
  ///
  /// In en, this message translates to:
  /// **'Refine'**
  String get projectRefinementTitle;

  /// Title for the projects section of the home page
  ///
  /// In en, this message translates to:
  /// **'Projects'**
  String get projectsTitle;

  /// Title for the field used to start the project creation flow.
  ///
  /// In en, this message translates to:
  /// **'What would you like to learn?'**
  String get projectSearchFieldTitle;

  /// Error message for when the app fails to retrieve projects.
  ///
  /// In en, this message translates to:
  /// **'Project retrieval failed'**
  String get projectsRetrievalError;

  /// Text for the search button
  ///
  /// In en, this message translates to:
  /// **'Engage'**
  String get searchButton;

  /// A title for the profile image selection screen
  ///
  /// In en, this message translates to:
  /// **'Select an Image'**
  String get selectAnImage;

  /// Text for the steps sections of the project guides
  ///
  /// In en, this message translates to:
  /// **'Steps'**
  String get steps;

  /// Text for the supplies sections of the project guides
  ///
  /// In en, this message translates to:
  /// **'Supplies'**
  String get supplies;

  /// Text for a button that allows the user to view the terms of service.
  ///
  /// In en, this message translates to:
  /// **'terms of service'**
  String get termsOfService;

  /// Text for the tips sections of the project guides
  ///
  /// In en, this message translates to:
  /// **'Tips'**
  String get tips;

  /// Text for the tools sections of the project guides
  ///
  /// In en, this message translates to:
  /// **'Tools'**
  String get tools;

  /// Text displayed while the app is updating a project.
  ///
  /// In en, this message translates to:
  /// **'Updating project...'**
  String get updatingProject;

  /// Label for the username field
  ///
  /// In en, this message translates to:
  /// **'Username'**
  String get usernameLabel;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
