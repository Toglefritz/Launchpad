import 'package:flutter/material.dart';
import 'package:launchpad_app/theme/insets.dart';

/// The [Slide] widget represents an individual slide in the presentation.
///
/// Each slide displays the slide content on the left side and the Launchpad app widget on the right side. The content
/// portion of each slide is a generic widget that can be customized to display any content.
///
/// For the Launchpad app portion of the slide, it is important that the same widget instance is used for all slides.
/// This is because the Launchpad app widget is used to demonstrate the Launchpad app in action, and it should be
/// consistent across all slides, maintaining the same state and behavior throughout the presentation. Therefore,
/// the Launchpad app widget should be created once and the same instance should be used for all slides.
///
/// For aesthetics, the Launchpad app widget on the right side of the screen is placed within a frame appearing like
/// a physical device. This frame is not part of the Launchpad app widget itself, but is a visual representation
/// to enhance the presentation.
class Slide extends StatelessWidget {
  /// The content to be displayed on the left side of the slide.
  final Widget content;

  /// The Launchpad app widget to be displayed on the right side of the slide. Using the same instance of the Launchpad
  /// app widget across all slides ensures consistency in the behavior and state of the Launchpad app throughout the
  /// presentation.
  final Widget launchpadApp;

  /// Creates an instance of [Slide].
  ///
  /// The [content] parameter represents the slide content that will be displayed on the left side, while the
  /// [launchpadApp] parameter represents the Launchpad app widget that will be displayed on the right side.
  const Slide({
    required this.content,
    required this.launchpadApp,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Content on the left side
        Expanded(
          flex: 2,
          child: Padding(
            padding: const EdgeInsets.all(
              Insets.medium,
            ),
            child: content,
          ),
        ),
        // Launchpad app on the right side
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(
              Insets.medium,
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(Insets.small),
                  child: launchpadApp,
                ),
                // Frame around the Launchpad app
                Image.asset('assets/pixel_8_pro.png'),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
