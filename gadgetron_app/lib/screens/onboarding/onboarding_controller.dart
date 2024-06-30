import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:gadgetron_app/screens/navigation_wrapper/navigation_wrapper_route.dart';
import 'package:gadgetron_app/screens/onboarding/models/authentication_mode.dart';
import 'package:gadgetron_app/screens/onboarding/onboarding_route.dart';
import 'package:gadgetron_app/screens/onboarding/onboarding_view.dart';
import 'package:gadgetron_app/services/firebase_auth/authentication_service.dart';
import 'package:gadgetron_app/services/firebase_auth/models/auth_methods.dart';
import 'package:gadgetron_app/services/firebase_auth/models/firebase_auth_exception_message.dart';

/// A controller for the [OnboardingRoute] widget.
class OnboardingController extends State<OnboardingRoute> {
  /// A key for the [Form] widget used for basic authentication. This key is used to validate the form after the user
  /// submits their username and password.
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  /// A controller for the [TextField] widget used to enter the user's username (email address) when using a
  /// username/password login method.
  final TextEditingController usernameController = TextEditingController();

  /// A controller for the [TextField] widget used to enter the user's password when using a username/password
  /// login method.
  final TextEditingController passwordController = TextEditingController();

  /// Determines the action the user is attempting to complete by submitting their username and password, either
  /// logging into an existing account or creating a new account.
  AuthenticationMode authenticationMode = AuthenticationMode.login;

  /// An error message set by exceptions thrown during the authentication process related to the username entry. These
  /// error messages will be displayed above the button used to submit the form.
  String? authenticationExceptionMessage;

  /// A getter that determines if the current platform supports logging in with Google.
  bool get canAuthenticateWithGoogle => Platform.isAndroid || Platform.isIOS || Platform.isMacOS || kIsWeb;

  /// Handles changes in the authentication mode. This function is called when the user selects one of the two
  /// [ChoiceChip] widgets in the [OnboardingView] widget.
  void onAuthenticationModeChanged(AuthenticationMode mode) {
    setState(() {
      authenticationMode = mode;
    });
  }

  /// A validation function for the username field. This function checks if the username is a valid email address,
  /// which includes a check, by definition, that the username is not empty.
  String? validateEmail(String? email) {
    if (email == null || email.isEmpty) {
      return AppLocalizations.of(context)!.errorOnboardingEmailEmpty;
    }

    // Regex pattern for validating email address
    const pattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
    final regExp = RegExp(pattern);

    if (!regExp.hasMatch(email)) {
      return AppLocalizations.of(context)!.errorOnboardingInvalidEmail;
    }

    return null;
  }

  /// A validation function for the password field. This function checks if the password is not empty and is at least
  /// 8 characters long. Note that Firebase Auth will enforce additional password requirements that, if not met, will
  /// result in exceptions from the Firebase Auth API.
  String? validatePassword(String? password) {
    if (password == null || password.isEmpty) {
      return AppLocalizations.of(context)!.errorOnboardingPasswordEmpty;
    }

    if (password.length < 8) {
      return AppLocalizations.of(context)!.errorOnboardingPasswordTooShort;
    }

    return null;
  }

  /// Handles submission of username and password.
  ///
  /// The action performed by this method depends upon the current [AuthenticationMode] set in the [authenticationMode].
  /// This method calls either the [_login] or [_createAccount] method, depending on this value. In either case,
  /// assuming the processes are not successful, a variety of exceptions can the thrown from the Firebase Auth plugin
  /// for various issues. These exceptions are caught and handled by setting the [authenticationExceptionMessage] field
  /// to a user-friendly error message. If the authentication processes are successful, the [NavigationWrapperRoute]
  /// automatically handles displaying the appropriate page following the change in authentication state.
  Future<void> onAuthenticate() async {
    // Validate the username and password.
    if (formKey.currentState!.validate()) {
      try {
        switch (authenticationMode) {
          case AuthenticationMode.login:
            await _login();
          case AuthenticationMode.createAccount:
            await _createAccount();
        }
      } catch (e) {
        // An exception caught here means that something unexpected has happened during the authentication process.
        // The _login and _createAccount methods catch FirebaseAuthExceptions so this exception indicates that something
        // outside of the Firebase Auth system went wrong.
        setState(() {
          authenticationExceptionMessage = AppLocalizations.of(context)!.errorOnboardingFailedToAuthenticate;
        });
      }
    }
  }

  /// Attempts to create an account with the provided username and password.
  Future<void> _createAccount() async {
    final String username = usernameController.text;
    final String password = passwordController.text;

    try {
      await AuthenticationService.createUser(
        method: AuthMethod.basicAuth,
        emailAddress: username,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == FirebaseAuthExceptionMessage.weakPassword.message) {
        setState(() {
          authenticationExceptionMessage = AppLocalizations.of(context)!.errorOnboardingWeakPassword;
        });
      } else if (e.code == FirebaseAuthExceptionMessage.emailAlreadyInUse.message) {
        setState(() {
          authenticationExceptionMessage = AppLocalizations.of(context)!.errorOnboardingEmailInUse;
        });
      } else {
        setState(() {
          authenticationExceptionMessage = AppLocalizations.of(context)!.errorOnboardingFailedToAuthenticate;
        });
      }
    }
  }

  /// Attempts to log in with the provided username and password.
  Future<void> _login() async {
    final String username = usernameController.text;
    final String password = passwordController.text;

    try {
      await AuthenticationService.login(
        emailAddress: username,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == FirebaseAuthExceptionMessage.userNotFound.message) {
        setState(() {
          authenticationExceptionMessage = AppLocalizations.of(context)!.errorOnboardingUserNotFound;
        });
      } else if (e.code == FirebaseAuthExceptionMessage.wrongPassword.message) {
        setState(() {
          authenticationExceptionMessage = AppLocalizations.of(context)!.errorOnboardingWrongPassword;
        });
      } else {
        setState(() {
          authenticationExceptionMessage = AppLocalizations.of(context)!.errorOnboardingFailedToAuthenticate;
        });
      }
    }
  }

  /// Handles taps on the button used to begin authentication with a Google account.
  ///
  /// This function will attempt to authenticate with Google using the `GoogleSignIn` plugin. The function completes
  /// the following operations:
  ///   1.  The function attempts to sign in with Google.
  ///   2.  If the sign-in is successful, the function will attempt to create an account with the provided Google
  ///       credentials.
  ///   3.  If the account creation is successful, the change in authentication state will be handled automatically.
  ///   4.  If an error occurs during the process, an error message will be displayed to the user.
  Future<void> onAuthenticateWithGoogle() async {
    // TODO(Toglefritz): Implement this function.
  }

  @override
  Widget build(BuildContext context) => OnboardingView(this);
}
