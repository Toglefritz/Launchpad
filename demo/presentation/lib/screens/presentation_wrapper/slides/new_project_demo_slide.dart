import 'package:flutter/material.dart';
import 'package:launchpad_app/theme/insets.dart';
import 'package:presentation/screens/components/fade_in_list.dart';
import 'package:presentation/screens/components/slide.dart';

/// A slide that demonstrates creating a new project in the Launchpad app.
class NewProjectDemoSlide extends StatelessWidget {
  /// Create an instance of the [NewProjectDemoSlide] widget.
  const NewProjectDemoSlide({
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
                'Create a New Project',
                style: Theme.of(context).textTheme.displayLarge,
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(Insets.medium),
              child: FadeInList(
                items: [
                  '1. Tap the button to start a new project.',
                  '2. Enter a learning goal.',
                  '3. Gemini will generate a project draft from this goal.',
                  '4. Review and refine this draft with additional prompts to Gemini.',
                  '5. Approve the project.',
                  '6. Start learning!',
                ],
              ),
            ),
          ],
        ),
      ),
      launchpadApp: launchpadApp,
    );
  }
}
