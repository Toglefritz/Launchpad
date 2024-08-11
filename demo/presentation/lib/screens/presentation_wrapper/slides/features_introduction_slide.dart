import 'package:flutter/material.dart';
import 'package:launchpad_app/theme/insets.dart';
import 'package:presentation/screens/components/slide.dart';

/// A slide that introduces the main features of the Launchpad app.
class FeaturesIntroductionSlide extends StatelessWidget {
  /// Create an instance of the [FeaturesIntroductionSlide] widget.
  const FeaturesIntroductionSlide({
    required this.launchpadApp,
    super.key,
  });

  /// The Launchpad app widget to be displayed on the right side of this slide.
  final Widget launchpadApp;

  @override
  Widget build(BuildContext context) {
    return Slide(
      content: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: Insets.large,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(Insets.medium),
              child: Text(
                'Features',
                style: Theme.of(context).textTheme.displayLarge,
              ),
            ),
            ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                Container(
                  margin: const EdgeInsets.all(Insets.medium),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                    color: Theme.of(context).primaryColorLight,
                  ),
                  child: ListTile(
                    title: Text(
                      'Personalized Learning Pathways',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    subtitle: Text(
                      'Tailored project recommendations based on your interests, goals, and skill level.',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(Insets.medium),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                    color: Theme.of(context).primaryColorLight,
                  ),
                  child: ListTile(
                    title: Text(
                      'AI-Powered Assistance',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    subtitle: Text(
                      'A virtual mentor available 24/7 to provide hints, answer questions, and offer encouragement.',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(Insets.medium),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                    color: Theme.of(context).primaryColorLight,
                  ),
                  child: ListTile(
                    title: Text(
                      'Achievements and Rewards',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    subtitle: Text(
                      'Earn badges, certificates, and rewards as you complete projects and reach milestones.',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      launchpadApp: launchpadApp,
    );
  }
}
