import 'package:flutter/material.dart';
import 'package:launchpad_app/theme/insets.dart';
import 'package:presentation/screens/components/slide.dart';

/// A slide presenting a conclusion to the presentation.
class ConclusionSlide extends StatelessWidget {
  /// Create an instance of the [ConclusionSlide] widget.
  const ConclusionSlide({
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
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: Image.asset(
                'assets/app_icon.png',
                width: 250,
                height: 250,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: Insets.large,
              ),
              child: Text(
                'Launchpad',
                style: Theme.of(context).textTheme.displayLarge?.copyWith(
                  fontSize: 72,
                ),
              ),
            ),
            Text(
              'Thank you for watching!',
              style: Theme.of(context).textTheme.displaySmall,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
      launchpadApp: launchpadApp,
    );
  }
}
