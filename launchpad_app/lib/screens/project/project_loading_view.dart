import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:launchpad_app/components/loader/wave_loading_indicator.dart';
import 'package:launchpad_app/screens/project/project_controller.dart';
import 'package:launchpad_app/screens/project/project_route.dart';
import 'package:launchpad_app/theme/insets.dart';

/// A view for the [ProjectRoute] widget.
///
/// This view is displayed while the app is assembling the project data following refinement by the user.
class ProjectLoadingView extends StatelessWidget {
  /// A controller for this view.
  final ProjectController state;

  /// Creates an instance of the [ProjectLoadingView] widget.
  const ProjectLoadingView(
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
                  AppLocalizations.of(context)!.preparingProject,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
              Text(
                AppLocalizations.of(context)!.projectLoadingDescription,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
