import 'package:launchpad_app/screens/onboarding/onboarding_controller.dart';
import 'package:launchpad_app/screens/onboarding/onboarding_route.dart';

/// An enumeration of authentication modes for the [OnboardingRoute]. The mode determines the logic executed in the
/// [OnboardingController] when the user submits their username and password. Even though the user interface is
/// extremely similar for both modes, the controller logic is different. Additionally, its awareness of the intended
/// action by the user allows the controller to display more useful error messages in the event of a failure during
/// the authentication processes.
enum AuthenticationMode {
  /// The user is logging in with a username and password.
  login,

  /// The user is creating an account with a username and password.
  createAccount,
}
