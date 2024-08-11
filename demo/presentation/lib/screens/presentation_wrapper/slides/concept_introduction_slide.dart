import 'package:flutter/material.dart';
import 'package:launchpad_app/theme/insets.dart';
import 'package:presentation/screens/components/slide.dart';

/// A slide that introduces the core idea of the Launchpad app, that is, learning through real-world projects.
class ConceptIntroductionSlide extends StatelessWidget {
  /// Create an instance of the [ConceptIntroductionSlide] widget.
  const ConceptIntroductionSlide({
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
            Text(
              '"The only source of knowledge is experience"',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontStyle: FontStyle.italic,
                  ),
            ),
            Padding(
              padding: const EdgeInsets.all(
                Insets.large,
              ),
              child: Text(
                '- Albert Einstein',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontStyle: FontStyle.italic,
                    ),
              ),
            ),
          ],
        ),
      ),
      launchpadApp: launchpadApp,
    );
  }
}
