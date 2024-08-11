import 'package:flutter/material.dart';
import 'package:launchpad_app/launchpad_app.dart';
import 'package:launchpad_app/screens/navigation_wrapper/navigation_wrapper_controller.dart';
import 'package:presentation/screens/presentation_wrapper/presentation_wrapper_controller.dart';
import 'package:presentation/screens/presentation_wrapper/slides/concept_introduction_slide.dart';
import 'package:presentation/screens/presentation_wrapper/slides/introduction_slide.dart';

/// A view for the [NavigationWrapperController] widget.
class PresentationWrapperView extends StatelessWidget {
  /// A controller for this view.
  final PresentationWrapperController state;

  /// Creates an instance of the [PresentationWrapperView] widget.
  const PresentationWrapperView(
    this.state, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // A LaunchpadApp instance used for demonstrations throughout the presentation.
    const Widget launchpadApp = LaunchpadApp();

    return Scaffold(
      body: PageView(
        children: const <Widget>[
          IntroductionSlide(),
          ConceptIntroductionSlide(
            launchpadApp: launchpadApp,
          ),
        ],
      ),
    );
  }
}
