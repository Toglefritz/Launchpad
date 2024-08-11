import 'package:flutter/material.dart';
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
      body: Placeholder(),
    );
  }
}
