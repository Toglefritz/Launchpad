import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:launchpad_app/components/dashed_outlines/dashed_divider.dart';
import 'package:launchpad_app/components/buttons/secondary_cta_button.dart';
import 'package:launchpad_app/screens/onboarding/components/basic_auth_form.dart';
import 'package:launchpad_app/screens/onboarding/components/onboarding_legal_prompt.dart';
import 'package:launchpad_app/screens/onboarding/onboarding_controller.dart';
import 'package:launchpad_app/theme/insets.dart';

/// A view for the [OnboardingController] widget.
class OnboardingView extends StatelessWidget {
  /// A controller for this view.
  final OnboardingController state;

  /// Creates an instance of the [OnboardingView] widget.
  const OnboardingView(
    this.state, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // Dismiss the keyboard when the user taps outside of the text fields.
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: SafeArea(
          child: CustomScrollView(
            slivers: <Widget>[
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(
                  Insets.medium,
                  Insets.medium,
                  Insets.medium,
                  Insets.tiny,
                ),
                sliver: SliverToBoxAdapter(
                  child: Text(
                    AppLocalizations.of(context)!.onboardingTitle,
                    style: Theme.of(context).textTheme.headlineSmall,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(
                  Insets.medium,
                  Insets.tiny,
                  Insets.medium,
                  Insets.medium,
                ),
                sliver: SliverToBoxAdapter(
                  child: Text(
                    AppLocalizations.of(context)!.appName,
                    style: Theme.of(context).textTheme.headlineLarge,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.all(Insets.medium),
                sliver: SliverToBoxAdapter(
                  child: Text(
                    AppLocalizations.of(context)!.onboardingDescription,
                    style: Theme.of(context).textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: BasicAuthForm(state: state),
              ),
              if (state.canAuthenticateWithGoogle)
                const SliverPadding(
                  padding: EdgeInsets.all(Insets.medium),
                  sliver: SliverToBoxAdapter(
                    child: DashedDivider(),
                  ),
                ),

              // Google authentication button
              if (state.canAuthenticateWithGoogle)
                SliverPadding(
                  padding: const EdgeInsets.all(Insets.medium),
                  sliver: SliverToBoxAdapter(
                    child: SecondaryCTAButton(
                      onPressed: state.onAuthenticateWithGoogle,
                      icon: Image.asset(
                        'assets/g-logo.png',
                        height: 32,
                      ),
                      label: Text(
                        AppLocalizations.of(context)!.continueWithGoogle,
                      ),
                    ),
                  ),
                ),

              // Terms and conditions and privacy policy buttons
              const SliverSafeArea(
                sliver: SliverPadding(
                  padding: EdgeInsets.symmetric(horizontal: Insets.medium),
                  sliver: SliverFillRemaining(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        OnboardingLegalPrompt(),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
