import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:gadgetron_app/screens/onboarding/onboarding_controller.dart';
import 'package:gadgetron_app/theme/insets.dart';

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
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(Insets.medium),
                child: Text(
                  AppLocalizations.of(context)!.onboardingTitle,
                  style: Theme.of(context).textTheme.headlineSmall,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
