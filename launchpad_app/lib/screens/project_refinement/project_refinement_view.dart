import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:launchpad_app/components/app_bar/app_bar_button.dart';
import 'package:launchpad_app/components/buttons/primary_cta_button.dart';
import 'package:launchpad_app/screens/project_refinement/project_refinement_controller.dart';
import 'package:launchpad_app/screens/project_refinement/project_refinement_route.dart';
import 'package:launchpad_app/services/project/how_to_direction.dart';
import 'package:launchpad_app/services/project/how_to_step.dart';
import 'package:launchpad_app/services/project/how_to_supply.dart';
import 'package:launchpad_app/services/project/how_to_tip.dart';
import 'package:launchpad_app/services/project/how_to_tool.dart';
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
        title: Text(
          AppLocalizations.of(context)!.projectRefinementTitle,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontSize: 24,
              ),
        ),
      ),
      body: SafeArea(
        child: CustomScrollView(
          physics: const ClampingScrollPhysics(),
          slivers: <Widget>[
            // Project title
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: Insets.medium),
              sliver: SliverToBoxAdapter(
                child: Text(
                  state.project!.name,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ),
            ),

            // Project description
            SliverPadding(
              padding: const EdgeInsets.all(Insets.medium),
              sliver: SliverToBoxAdapter(
                child: Text(
                  state.project!.description,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ),

            // Project directions
            if (state.project!.steps.isNotEmpty)
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(Insets.medium),
                  child: Text(
                    AppLocalizations.of(context)!.directions,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ),
              ),
            if (state.project!.steps.isNotEmpty)
              SliverToBoxAdapter(
                child: Stepper(
                  physics: const NeverScrollableScrollPhysics(),
                  currentStep: state.currentStep,
                  onStepTapped: state.onStepTapped,
                  connectorThickness: 2.0,
                  steps: state.project!.steps
                      .map(
                        (HowToStep step) => Step(
                          stepStyle: StepStyle(
                            color: Theme.of(context).primaryColorDark,
                          ),
                          title: Text(
                            step.name,
                          ),
                          content: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (step.description != null)
                                Text(
                                  step.description!,
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ExpansionTile(
                                title: Text(
                                  AppLocalizations.of(context)!.steps,
                                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                                children: List.generate(step.directions.length, (index) {
                                  final HowToDirection direction = step.directions[index];

                                  return Padding(
                                    padding: const EdgeInsets.symmetric(vertical: Insets.small),
                                    child: RichText(
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                            text: '${index + 1}. ',
                                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                          ),
                                          TextSpan(
                                            text: direction.text,
                                            style: Theme.of(context).textTheme.bodyMedium,
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                              ),
                              if (step.tools?.isNotEmpty ?? false)
                                ExpansionTile(
                                  title: Text(
                                    AppLocalizations.of(context)!.tools,
                                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                  children: step.tools!
                                      .map(
                                        (HowToTool tool) => ListTile(
                                          title: Text('\u2022 ${tool.name}'),
                                        ),
                                      )
                                      .toList(),
                                ),
                              if (step.supplies?.isNotEmpty ?? false)
                                ExpansionTile(
                                  title: Text(
                                    AppLocalizations.of(context)!.supplies,
                                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                  children: step.supplies!
                                      .map(
                                        (HowToSupply supply) => ListTile(
                                          title: Text('\u2022 ${supply.name}'),
                                        ),
                                      )
                                      .toList(),
                                ),
                            ],
                          ),
                        ),
                      )
                      .toList(),
                  controlsBuilder: (BuildContext context, ControlsDetails details) {
                    // Hide the controls.
                    return const SizedBox.shrink();
                  },
                ),
              ),

            // Project tools
            if (state.project!.tools?.isNotEmpty ?? false)
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: Insets.medium),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: Insets.medium),
                        child: Text(
                          AppLocalizations.of(context)!.tools,
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                      ),
                      Column(
                        children: state.project!.tools!
                            .map(
                              (HowToTool tool) => ListTile(
                                title: Text('\u2022 ${tool.name}'),
                              ),
                            )
                            .toList(),
                      ),
                    ],
                  ),
                ),
              ),

            // Project supplies
            if (state.project!.supplies?.isNotEmpty ?? false)
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: Insets.medium),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: Insets.medium),
                        child: Text(
                          AppLocalizations.of(context)!.supplies,
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                      ),
                      Column(
                        children: state.project!.supplies!
                            .map(
                              (HowToSupply supply) => ListTile(
                                title: Text('\u2022 ${supply.name}'),
                              ),
                            )
                            .toList(),
                      ),
                    ],
                  ),
                ),
              ),

            // Project tips
            if (state.project!.tips?.isNotEmpty ?? false)
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: Insets.medium),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: Insets.medium),
                        child: Text(
                          AppLocalizations.of(context)!.tips,
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                      ),
                      Column(
                        children: state.project!.tips!
                            .map(
                              (HowToTip tip) => Padding(
                                padding: const EdgeInsets.symmetric(vertical: Insets.small),
                                child: Text('\u2022 ${tip.text}'),
                              ),
                            )
                            .toList(),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Insets.medium),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: Insets.small),
                child: Text(
                  AppLocalizations.of(context)!.projectRefinementRequest,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: Insets.small),
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
              SizedBox(
                width: double.infinity, // Makes the button stretch to fill the width
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: Insets.small),
                  child: PrimaryCTAButton(
                    onPressed: state.onProjectAccepted,
                    icon: const Icon(Icons.thumb_up),
                    label: Text(AppLocalizations.of(context)!.projectApprovalButton.toUpperCase()),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
