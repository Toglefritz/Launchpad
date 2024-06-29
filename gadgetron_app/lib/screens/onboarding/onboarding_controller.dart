import 'package:flutter/material.dart';
import 'package:gadgetron_app/screens/navigation_wrapper/navigation_wrapper_route.dart';
import 'package:gadgetron_app/screens/onboarding/onboarding_route.dart';
import 'package:gadgetron_app/screens/onboarding/onboarding_view.dart';

/// A controller for the [OnboardingRoute] widget.
class OnboardingController extends State<OnboardingRoute> {
  /// A controller for the [TextField] widget used to enter the user's username (email address) when using a
  /// username/password login method.
  final TextEditingController usernameController = TextEditingController();

  /// A controller for the [TextField] widget used to enter the user's password when using a username/password
  /// login method.
  final TextEditingController passwordController = TextEditingController();

  /// Handles submission of username and password. This function completes the following operations:
  ///
  /// 1.  Validates the username and password.
  /// 2.  If the username and password are valid, the function attempts to create an account with the provided
  ///     username and password.
  /// 3.  If an error is returned indicating that the account already exists, the function attempts to sign in
  ///     with the provided username and password.
  /// 4.  If an error is returned from part of this process, an error message is displayed to the user.
  /// 5.  If successful, the change in authentication state will be handled automatically by the
  ///     [NavigationWrapperRoute].
  Future<void> onAuthenticate() async {
    // TODO(Toglefritz): Implement this function.
  }

  @override
  Widget build(BuildContext context) => OnboardingView(this);
}
