import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:launchpad_app/components/buttons/tertiary_cta_button.dart';
import 'package:launchpad_app/components/loader/wave_loading_indicator.dart';
import 'package:launchpad_app/screens/home/components/project_card.dart';
import 'package:launchpad_app/screens/home/home_controller.dart';
import 'package:launchpad_app/services/project/augmented_project.dart';
import 'package:launchpad_app/theme/insets.dart';

/// A view for the [HomeController] widget.
class HomeView extends StatelessWidget {
  /// A controller for this view.
  final HomeController state;

  /// Creates an instance of the [HomeView] widget.
  const HomeView(
    this.state, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.homeTitle,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontSize: 24,
              ),
        ),
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverPadding(
              padding: const EdgeInsets.all(Insets.medium),
              sliver: SliverToBoxAdapter(
                child: Text(
                  AppLocalizations.of(context)!.yourProjectsTitle,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
            ),

            // Show a loading indicator while the app is working on getting the projects list
            if (state.projects == null && !state.hasError)
              SliverPadding(
                padding: const EdgeInsets.all(Insets.small),
                sliver: SliverToBoxAdapter(
                  child: SizedBox(
                    height: 131.0 + MediaQuery.textScalerOf(context).scale(16) * 4 + Insets.small * 5,
                    child: const WaveLoadingIndicator(),
                  ),
                ),
              ),

            // If an error occurred while fetching the projects list, show an error message.
            if (state.hasError)
              SliverPadding(
                padding: const EdgeInsets.all(Insets.medium),
                sliver: SliverToBoxAdapter(
                  child: Text(
                    AppLocalizations.of(context)!.projectsRetrievalError,
                    style: TextStyle(color: Colors.red[900]),
                  ),
                ),
              ),

            // If the projects list is empty, show a message indicating that the user has no projects
            if (state.projects != null && state.projects!.isEmpty)
              SliverPadding(
                padding: const EdgeInsets.symmetric(
                  horizontal: Insets.medium,
                  vertical: Insets.small,
                ),
                sliver: SliverToBoxAdapter(
                  child: Text(
                    AppLocalizations.of(context)!.noProjectsFound,
                  ),
                ),
              ),

            // If the projects list is not empty, show the list of projects
            if (state.projects != null && state.projects!.isNotEmpty)
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 131.0 + MediaQuery.textScalerOf(context).scale(16) * 4 + Insets.small * 5,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal, // Set the scroll direction to horizontal
                    itemCount: state.projects!.length,
                    itemBuilder: (BuildContext context, int index) {
                      final AugmentedProject project = state.projects![index];

                      return Padding(
                        padding: const EdgeInsets.all(Insets.small),
                        child: GestureDetector(
                          onTap: () => state.onProjectSelected(project),
                          child: ProjectCard(project: project),
                        ),
                      );
                    },
                  ),
                ),
              ),

            SliverPadding(
              padding: const EdgeInsets.all(Insets.medium),
              sliver: SliverToBoxAdapter(
                child: TertiaryCTAButton(
                  onPressed: state.onNewProject,
                  icon: const Icon(Icons.add),
                  label: Text(AppLocalizations.of(context)!.newProject),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
