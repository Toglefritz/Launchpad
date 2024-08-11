import 'package:flutter/material.dart';
import 'package:launchpad_app/launchpad_app.dart';
import 'package:launchpad_app/screens/navigation_wrapper/navigation_wrapper_controller.dart';
import 'package:presentation/screens/presentation_wrapper/presentation_wrapper_controller.dart';
import 'package:presentation/screens/presentation_wrapper/slides/concept_introduction_slide.dart';
import 'package:presentation/screens/presentation_wrapper/slides/features_introduction_slide.dart';
import 'package:presentation/screens/presentation_wrapper/slides/introduction_slide.dart';
import 'package:presentation/screens/presentation_wrapper/slides/new_project_demo_slide.dart';
import 'package:presentation/screens/presentation_wrapper/slides/project_demo_slide.dart';

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
          // An introduction to the presentation.
          IntroductionSlide(),

          // A secondary introduction illustrating the core concept of the Launchpad app.
          ConceptIntroductionSlide(
            launchpadApp: launchpadApp,
          ),

          // A list of the app's main features.
          FeaturesIntroductionSlide(
            launchpadApp: launchpadApp,
          ),

          // A demonstration of creating a new project in the Launchpad app.
          NewProjectDemoSlide(
            launchpadApp: launchpadApp,
          ),

          // A demonstration of working on a project in the Launchpad app.
          ProjectDemoSlide(
            launchpadApp: launchpadApp,
          ),

          // A conclusion to the presentation.
          // TODO(Toglefritz): Add a conclusion slide.
        ],
      ),
    );
  }
}
