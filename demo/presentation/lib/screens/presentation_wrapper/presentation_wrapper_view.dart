import 'package:flutter/material.dart';
import 'package:launchpad_app/screens/navigation_wrapper/navigation_wrapper_controller.dart';
import 'package:presentation/screens/components/slide.dart';
import 'package:presentation/screens/presentation_wrapper/presentation_wrapper_controller.dart';

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
    return Scaffold(
      body: PageView(
        children: <Slide>[
          Slide(
            content: Column(
              children: [
                Text(
                  'Launchpad',
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                Text(
                  'Gain knowledge and skills with real-world projects',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ],
            ),
            launchpadApp: const FlutterLogo(),
          ),
        ],
      ),
    );
  }
}
