import 'package:flutter/material.dart';
import 'package:launchpad_app/components/app_bar_button.dart';
import 'package:launchpad_app/screens/project_refinement/project_refinement_controller.dart';
import 'package:launchpad_app/screens/project_refinement/project_refinement_route.dart';
import 'package:launchpad_app/theme/insets.dart';

/// A view for the [ProjectRefinementRoute] widget.
///
/// This view is displayed after the app has obtained a response from Gemini for the user's project description
/// submission.
class ProjectRefinementView extends StatelessWidget {
  /// A controller for this view.
  final ProjectRefinementController state;

  /// Creates an instance of the [ProjectRefinementView] widget.
  const ProjectRefinementView(
    this.state, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: AppBarButton(
          icon: const Icon(Icons.arrow_back),
          onTap: () => Navigator.pop(context),
        ),
        actions: [
          AppBarButton(
            icon: const Icon(Icons.feedback_outlined),
            onTap: () => {
              // TODO(Toglefritz): implement feedback
            },
          ),
        ],
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: <Widget>[
            // TODO(Toglefritz): display project initial draft
            SliverFillRemaining(
              hasScrollBody: false,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(Insets.small),
                    child: TextField(
                      controller: state.refineFieldController,
                      maxLines: null,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          icon: !state.isWaitingForResponse
                              ? Icon(
                                  Icons.send,
                                  color: Theme.of(context).primaryColorDark,
                                )
                              : const SizedBox(
                                  height: 24.0,
                                  width: 24.0,
                                  child: CircularProgressIndicator(),
                                ),
                          onPressed: state.onRefinementQuery,
                        ),
                      ),
                      enabled: !state.isWaitingForResponse,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
