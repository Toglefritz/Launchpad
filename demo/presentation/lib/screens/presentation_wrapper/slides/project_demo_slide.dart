import 'package:flutter/material.dart';
import 'package:launchpad_app/theme/insets.dart';
import 'package:presentation/screens/components/fade_in_list.dart';
import 'package:presentation/screens/components/slide.dart';

/// A slide that demonstrates working with a project in the Launchpad app.
class ProjectDemoSlide extends StatelessWidget {
  /// Create an instance of the [ProjectDemoSlide] widget.
  const ProjectDemoSlide({
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
                'Work on a Project',
                style: Theme.of(context).textTheme.displayLarge,
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(Insets.medium),
              child: FadeInList(
                items: [
                  '1. Work through directions on each step.',
                  '2. Access tools and materials.',
                  '3. Earn achievements!',
                  '4. Ask for help if needed.',
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
