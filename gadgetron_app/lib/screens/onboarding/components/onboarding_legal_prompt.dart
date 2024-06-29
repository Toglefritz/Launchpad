import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:gadgetron_app/screens/privacy_policy/privacy_policy_route.dart';
import 'package:gadgetron_app/screens/terms/terms_and_conditions_route.dart';

/// A sentence built with a [RichText] widget prompting the user to view the terms and conditions and
/// the privacy policy before using the app.
class OnboardingLegalPrompt extends StatelessWidget {
  /// Creates an [OnboardingLegalPrompt].
  const OnboardingLegalPrompt({
    super.key,
  });

  /// Handles taps on the privacy policy link.
  Future<void> _onTermsAndConditionsTap(BuildContext context) async {
    await Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: (context) => const TermsAndConditionsRoute(),
      ),
    );
  }

  /// Handles taps on the privacy policy link.
  Future<void> _onPrivacyPolicyTap(BuildContext context) async {
    await Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: (context) => const PrivacyPolicyRoute(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: Theme.of(context).textTheme.bodySmall,
        text: AppLocalizations.of(context)!.onboardingLegalPrompt1,
        children: <TextSpan>[
          TextSpan(
            text: AppLocalizations.of(context)!.termsOfService,
            style: const TextStyle(fontWeight: FontWeight.bold),
            recognizer: TapGestureRecognizer()..onTap = () => _onTermsAndConditionsTap(context),
          ),
          TextSpan(
            text: AppLocalizations.of(context)!.and,
          ),
          TextSpan(
            text: AppLocalizations.of(context)!.privacyPolicy,
            style: const TextStyle(fontWeight: FontWeight.bold),
            recognizer: TapGestureRecognizer()..onTap = () => _onPrivacyPolicyTap(context),
          ),
          TextSpan(
            text: AppLocalizations.of(context)!.onboardingLegalPrompt2,
          ),
        ],
      ),
    );
  }
}
