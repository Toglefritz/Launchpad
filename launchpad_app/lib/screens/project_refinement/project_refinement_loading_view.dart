import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:launchpad_app/components/loader/wave_loading_indicator.dart';
import 'package:launchpad_app/screens/project_refinement/project_refinement_controller.dart';
import 'package:launchpad_app/screens/project_refinement/project_refinement_route.dart';
import 'package:launchpad_app/theme/insets.dart';

/// A view for the [ProjectRefinementRoute] widget.
///
/// This view is displayed after the app has submitted a query to Gemini but before a response has been received. It
/// simply displays a loading indicator to the user while this asynchronous process is underway.
class ProjectRefinementLoadingView extends StatelessWidget {
  /// A controller for this view.
  final ProjectRefinementController state;

  /// Creates an instance of the [ProjectRefinementLoadingView] widget.
  const ProjectRefinementLoadingView(
    this.state, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const WaveLoadingIndicator(),
              Padding(
                padding: const EdgeInsets.all(Insets.medium),
                child: Text(
                  state.hasResponse
                      ? AppLocalizations.of(context)!.updatingProject
                      : AppLocalizations.of(context)!.loadingResults,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
              Text(
                AppLocalizations.of(context)!.projectDraftLoadingDescription,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
