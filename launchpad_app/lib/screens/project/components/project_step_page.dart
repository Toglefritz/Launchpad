import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:launchpad_app/screens/project/components/project_query_field.dart';
import 'package:launchpad_app/screens/project/extensions/step_explore_extension.dart';
import 'package:launchpad_app/screens/project/model/view_mode.dart';
import 'package:launchpad_app/screens/project/project_controller.dart';
import 'package:launchpad_app/services/project/models/how_to_step.dart';
import 'package:launchpad_app/theme/insets.dart';

/// A page showing information for an individual project step.
///
/// This page is displayed within a [PageView] widget. It contains information about a single step in a project.
/// Depending on the content available for the step, this information may include a title, description, set of
/// directions, a list of tools, and a list of supplies needed for the step.
class ProjectStepPage extends StatelessWidget {
  /// Creates an instance of the [ProjectStepPage] widget.
  const ProjectStepPage({
    required this.step,
    required this.state,
    super.key,
  });

  /// The step for which this widget displays information.
  final HowToStep step;

  /// A controller for this view.
  final ProjectController state;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
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

              // A row of buttons used to display different information about the step, depending upon what content is
              // available for the step.
              if ((step.tools?.isNotEmpty ?? false) || (step.supplies?.isNotEmpty ?? false))
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // Directions chip
                    ChoiceChip(
                      label: Text(AppLocalizations.of(context)!.directions),
                      selected: state.viewMode == ViewMode.directions,
                      onSelected: (bool selected) {
                        state.onDirectionsPressed();
                      },
                    ),

                    // Tools chip
                    if (step.tools?.isNotEmpty ?? false)
                      ChoiceChip(
                        label: Text(AppLocalizations.of(context)!.tools),
                        selected: state.viewMode == ViewMode.tools,
                        onSelected: (bool selected) {
                          state.onToolsPressed();
                        },
                      ),

                    // Supplies chip
                    if (step.supplies?.isNotEmpty ?? false)
                      ChoiceChip(
                        label: Text(AppLocalizations.of(context)!.supplies),
                        selected: state.viewMode == ViewMode.supplies,
                        onSelected: (bool selected) {
                          state.onSuppliesPressed();
                        },
                      ),
                  ],
                ),
            ],
          ),
        ),
        if (state.viewMode == ViewMode.directions)
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

        if (state.viewMode == ViewMode.tools)
          SliverList.builder(
            itemCount: step.tools?.length ?? 0,
            itemBuilder: (BuildContext context, int index) => Padding(
              padding: const EdgeInsets.symmetric(vertical: Insets.small),
              child: Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: Insets.medium,
                  vertical: Insets.tiny,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  color: Theme.of(context).primaryColorLight,
                ),
                child: ListTile(
                  title: Text(
                    step.tools![index].name,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  trailing: GestureDetector(
                    onTap: () => {
                      // TODO(Toglefritz): Open Amazon affiliate link or the like
                    },
                    child: const Icon(Icons.shopping_cart_rounded),
                  ),
                  dense: true,
                ),
              ),
            ),
          ),

        if (state.viewMode == ViewMode.supplies)
          SliverList.builder(
            itemCount: step.supplies?.length ?? 0,
            itemBuilder: (BuildContext context, int index) => Padding(
              padding: const EdgeInsets.symmetric(vertical: Insets.small),
              child: Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: Insets.medium,
                  vertical: Insets.tiny,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  color: Theme.of(context).primaryColorLight,
                ),
                child: ListTile(
                  title: Text(
                    step.supplies![index].name,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  trailing: GestureDetector(
                    onTap: () => {
                      // TODO(Toglefritz): Open Amazon affiliate link or the like
                    },
                    child: const Icon(Icons.shopping_cart_rounded),
                  ),
                  dense: true,
                ),
              ),
            ),
          ),

        if (state.viewMode == ViewMode.directions && (state.currentStep?.reversedConversation.isNotEmpty ?? false))
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(Insets.medium),
              child: Text(
                AppLocalizations.of(context)!.conversationTitle,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
          ),

        if (state.viewMode == ViewMode.directions && (state.currentStep?.reversedConversation.isNotEmpty ?? false))
          SliverPadding(
            padding: const EdgeInsets.symmetric(
              horizontal: Insets.medium,
            ),
            sliver: SliverList.builder(
              itemCount: state.currentStep!.reversedConversation.length,
              itemBuilder: (BuildContext context, int index) {
                return ExpansionTile(
                  title: Text(
                    state.currentStep!.reversedConversation[index].query,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  children: <Widget>[
                    Text(
                      state.currentStep!.reversedConversation[index].response,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                );
              },
            ),
          ),

        if (state.viewMode == ViewMode.directions)
          SliverFillRemaining(
            hasScrollBody: false,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: Insets.small,
                horizontal: Insets.medium,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 500),
                    child: state.currentPage != 0 ? ProjectQueryField(state: state) : const SizedBox.shrink(),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}
