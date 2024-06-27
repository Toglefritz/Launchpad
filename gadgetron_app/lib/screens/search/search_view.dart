import 'package:flutter/material.dart';

import 'package:gadgetron_app/screens/search/search_controller.dart';

/// A view for the [ProjectSearchController] widget.
class ProjectSearchView extends StatelessWidget {
  /// A controller for this view.
  final ProjectSearchController state;

  /// Creates an instance of the [ProjectSearchView] widget.
  const ProjectSearchView(
    this.state, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.network(
          'https://i.giphy.com/media/v1.Y2lkPTc5MGI3NjExNDM4bmFya3Z4OXJiajl0YTZzdDVsNmE4cmh4Mms5cXdyeTltcXBzOCZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/bKnEnd65zqxfq/giphy.gif',
        ),
      ),
    );
  }
}
