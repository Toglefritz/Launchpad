import 'package:flutter/material.dart';
import 'package:gadgetron_app/screens/onboarding/onboarding_controller.dart';

/// A route enabling the user to "search" for resources by describing a project.
///
/// One of the key tools provided by the Gadgetron app is the ability to search for resources by describing a project.
/// This route contains a text input field in which the user can enter a project description. From this description,
/// the app will generate a list of resources that match the project description. The resources may include product
/// recommendations, educational resources, explanations of key concepts, feedback, and more.
class OnboardingRoute extends StatefulWidget {
  /// Creates an instance of the [OnboardingRoute] widget.
  const OnboardingRoute({super.key});

  @override
  State<OnboardingRoute> createState() => OnboardingController();
}
