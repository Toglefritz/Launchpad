import 'package:flutter/material.dart';
import 'package:presentation/screens/presentation_wrapper/presentation_wrapper_controller.dart';

/// A route providing the basic infrastructure for the presentation, including the [PageView] widget used to display the
/// slides.
///
/// This route is the root of the presentation, and is responsible for displaying the slides in the presentation. It is
/// also responsible for handling the gestures that allow the user to navigate between slides. Last, it provides
/// thumbnails of all slides in the presentation, which can be used to navigate to a specific slide, or simply to
/// determine progress through the presentation.
class PresentationWrapperRoute extends StatefulWidget {
  /// Creates an instance of the [PresentationWrapperRoute] widget.
  const PresentationWrapperRoute({super.key});

  @override
  PresentationWrapperController createState() => PresentationWrapperController();
}
