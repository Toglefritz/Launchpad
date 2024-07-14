import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:launchpad_app/components/loader/wave_loading_indicator.dart';
import 'package:launchpad_app/screens/project_explore/project_explore_controller.dart';
import 'package:launchpad_app/screens/project_search/project_search_controller.dart';
import 'package:launchpad_app/theme/insets.dart';

/// A view for the [ProjectSearchController] widget.
///
/// This view is displayed after the app has submitted a query to Gemini but before a response has been received. It
/// simply displays a loading indicator to the user while this asynchronous process is underway.
class ProjectExploreLoadingView extends StatelessWidget {
  /// A controller for this view.
  final ProjectExploreController state;

  /// Creates an instance of the [ProjectExploreLoadingView] widget.
  const ProjectExploreLoadingView(
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
                  // TODO(Toglefritz): depending upon typical loading time, consider changing this text periodically
                  AppLocalizations.of(context)!.loadingResults,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
