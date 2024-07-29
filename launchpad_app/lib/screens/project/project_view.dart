import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:launchpad_app/components/app_bar/app_bar_button.dart';
import 'package:launchpad_app/components/app_bar/app_bar_popup_menu.dart';
import 'package:launchpad_app/components/buttons/secondary_cta_button.dart';
import 'package:launchpad_app/components/image_placeholders/decorative_background.dart';
import 'package:launchpad_app/screens/project/components/dot_indicator.dart';
import 'package:launchpad_app/screens/project/project_controller.dart';
import 'package:launchpad_app/services/project/augmented_project.dart';
import 'package:launchpad_app/services/project/models/how_to_step.dart';
import 'package:launchpad_app/theme/insets.dart';

/// A view for the [ProjectController] widget.
class ProjectView extends StatelessWidget {
  /// A controller for this view.
  final ProjectController state;

  /// Creates an instance of the [ProjectView] widget.
  const ProjectView(
    this.state, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final AugmentedProject project = state.augmentedProject!;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        leading: AppBarButton(
          icon: const Icon(Icons.arrow_back),
          onTap: state.onBack,
        ),
        actions: [
          AppBarPopupMenu(
            items: [
              if (state.augmentedProject?.id != null)
                PopupMenuItem<void Function()>(
                  value: state.onDeleteProject,
                  child: Text(
                    AppLocalizations.of(context)!.deleteProject,
                    textAlign: TextAlign.center,
                  ),
                ),
            ],
          ),
        ],
      ),
      body: PageView(
        controller: state.pageController,
        onPageChanged: state.onPageChanged,
        children: [
          CustomScrollView(
            physics: const ClampingScrollPhysics(),
            slivers: <Widget>[
              // Project title
              SliverPadding(
                padding: const EdgeInsets.all(Insets.medium),
                sliver: SliverToBoxAdapter(
                  child: Text(
                    project.name,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ),
              ),

              // Project description
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(
                  Insets.medium,
                  0.0,
                  Insets.medium,
                  Insets.medium,
                ),
                sliver: SliverToBoxAdapter(
                  child: Text(
                    project.description,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
              ),

              // Project cover image
              if (project.projectImage != null)
                SliverPadding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: Insets.medium,
                  ),
                  sliver: SliverToBoxAdapter(
                    child: FutureBuilder(
                      future: project.projectImage?.getImageUrl(),
                      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                        return AnimatedSwitcher(
                          duration: const Duration(milliseconds: 250),
                          child: snapshot.connectionState == ConnectionState.waiting
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(12.0),
                                  child: const AspectRatio(
                                    aspectRatio: 1.0,
                                    child: DecorativeBackground(),
                                  ),
                                )
                              : ClipRRect(
                                  borderRadius: BorderRadius.circular(12.0),
                                  child: Image.network(
                                    snapshot.data!,
                                    fit: BoxFit.cover,
                                    errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) =>
                                        ClipRRect(
                                      borderRadius: BorderRadius.circular(12.0),
                                      child: const AspectRatio(
                                        aspectRatio: 1.0,
                                        child: DecorativeBackground(),
                                      ),
                                    ),
                                  ),
                                ),
                        );
                      },
                    ),
                  ),
                ),
              SliverPadding(
                padding: const EdgeInsets.all(Insets.medium),
                sliver: SliverToBoxAdapter(
                  child: SecondaryCTAButton(
                    icon: const Icon(
                      Icons.rocket_launch_rounded,
                    ),
                    label: Text(AppLocalizations.of(context)!.getStarted),
                    onPressed: state.onNextPage,
                  ),
                ),
              ),
            ],
          ),

          // Project steps
          for (final HowToStep step in project.steps)
            CustomScrollView(
              physics: const ClampingScrollPhysics(),
              slivers: <Widget>[
                // Project steps
                SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Step name
                      Padding(
                        padding: const EdgeInsets.all(Insets.medium),
                        child: Text(
                          step.name,
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                      ),

                      // Step description
                      if (step.description != null)
                        Padding(
                          padding: const EdgeInsets.fromLTRB(
                            Insets.medium,
                            0.0,
                            Insets.medium,
                            Insets.medium,
                          ),
                          child: Text(
                            step.description!,
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ),

                      // Step directions
                      // TODO(Toglefritz): Implement this section.
                    ],
                  ),
                ),
              ],
            ),
        ],
      ),
      bottomNavigationBar: ColoredBox(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: SafeArea(
          child: DotIndicator(
            currentIndex: state.currentPage,
            itemCount: state.augmentedProject?.steps.length ?? 0,
          ),
        ),
      ),
    );
  }
}
