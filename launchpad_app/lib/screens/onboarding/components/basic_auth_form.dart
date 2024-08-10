import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:launchpad_app/components/buttons/primary_cta_button.dart';
import 'package:launchpad_app/screens/onboarding/models/authentication_mode.dart';
import 'package:launchpad_app/screens/onboarding/onboarding_controller.dart';
import 'package:launchpad_app/screens/onboarding/onboarding_route.dart';
import 'package:launchpad_app/theme/insets.dart';

/// A form for the [OnboardingRoute] that allows the user to authenticate with a username and password (basic auth).
///
/// This form is used for either creating and new account or logging into an existing one. The [OnboardingController]
/// is responsible for determining the action the user is attempting to complete. Aside from displaying a pair of
/// [ChoiceChip] widgets allowing the user to select the action, the user interface for both actions is identical.
///
/// This form contains two [TextField] widgets for the user to enter their username and password. The form is validated
/// when the user presses the primary CTA button, which is a [PrimaryCTAButton] widget.
class BasicAuthForm extends StatelessWidget {
  /// Creates an instance of the [BasicAuthForm] widget.
  const BasicAuthForm({
    required this.state,
    super.key,
  });

  /// A controller for the [OnboardingController] widget.
  final OnboardingController state;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) => Form(
        key: state.formKey,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(Insets.medium),
              child: TextFormField(
                controller: state.usernameController,
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.usernameLabel,
                ),
                validator: state.validateEmail,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: Insets.medium,
              ),
              child: TextFormField(
                controller: state.passwordController,
                decoration: InputDecoration(
                  label: Container(
                    padding: const EdgeInsets.symmetric(horizontal: Insets.tiny),
                    child: Text(
                      AppLocalizations.of(context)!.passwordLabel,
                    ),
                  ),
                ),
                obscureText: true,
                validator: state.validatePassword,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(
                Insets.medium,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ChoiceChip(
                    label: SizedBox(
                      width: constraints.maxWidth / 3,
                      child: Text(
                        AppLocalizations.of(context)!.login,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    selected: state.authenticationMode == AuthenticationMode.login,
                    onSelected: (_) => state.onAuthenticationModeChanged(AuthenticationMode.login),
                  ),
                  ChoiceChip(
                    label: SizedBox(
                      width: constraints.maxWidth / 3,
                      child: Text(
                        AppLocalizations.of(context)!.createAccount,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    selected: state.authenticationMode == AuthenticationMode.createAccount,
                    onSelected: (_) => state.onAuthenticationModeChanged(AuthenticationMode.createAccount),
                  ),
                ],
              ),
            ),
            // If an error occurred during authentication, display the error message.
            if (state.authenticationExceptionMessage != null)
              Padding(
                padding: const EdgeInsets.only(
                  left: Insets.medium,
                  right: Insets.medium,
                  bottom: Insets.medium,
                ),
                child: Text(
                  state.authenticationExceptionMessage!,
                  style: Theme.of(context).inputDecorationTheme.errorStyle,
                ),
              ),
            Padding(
              padding: const EdgeInsets.only(bottom: Insets.medium),
              child: SizedBox(
                width: constraints.maxWidth - Insets.medium * 2,
                child: PrimaryCTAButton(
                  onPressed: state.onAuthenticate,
                  icon: Icon(
                    Icons.rocket_launch,
                    color: Theme.of(context).primaryColorLight,
                  ),
                  label: Text(
                    AppLocalizations.of(context)!.authenticationButtonText.toUpperCase(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
