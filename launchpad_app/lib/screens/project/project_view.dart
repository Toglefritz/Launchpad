import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:launchpad_app/components/app_bar/app_bar_button.dart';
import 'package:launchpad_app/components/app_bar/app_bar_popup_menu.dart';
import 'package:launchpad_app/screens/project/components/dot_indicator.dart';
import 'package:launchpad_app/screens/project/components/project_cover_page.dart';
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
          // Project cover page
          ProjectCoverPage(project: project, state: state),

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
                    ],
                  ),
                ),
                SliverList.builder(
                  itemCount: step.directions.length,
                  itemBuilder: (BuildContext context, int index) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: Insets.small),
                    child: CheckboxListTile(
                      title: RichText(
                        textScaler: MediaQuery.textScalerOf(context),
                        text: TextSpan(
                          text: '${index + 1}. ',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                          children: [
                            TextSpan(
                              text: step.directions[index].text,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        ),
                      ),
                      value: step.directions[index].isComplete,
                      onChanged: (_) => state.onDirectionCompleted(step.directions[index]),
                    ),
                  ),
                ),
              ],
            ),
        ],
      ),
      bottomNavigationBar: ColoredBox(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: Insets.medium),
            child: DotIndicator(
              currentIndex: state.currentPage,
              itemCount: state.augmentedProject?.steps.length ?? 0,
            ),
          ),
        ),
      ),
    );
  }
}
