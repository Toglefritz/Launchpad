import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:launchpad_app/components/buttons/secondary_cta_button.dart';
import 'package:launchpad_app/components/image_placeholders/decorative_background.dart';
import 'package:launchpad_app/screens/project/project_controller.dart';
import 'package:launchpad_app/services/project/augmented_project.dart';
import 'package:launchpad_app/theme/insets.dart';

/// A page displayed at the beginning of a project. This page shows the project's cover image, title, and description.
class ProjectCoverPage extends StatelessWidget {
  /// Creates an instance of [ProjectCoverPage].
  const ProjectCoverPage({
    required this.project,
    required this.state,
    super.key,
  });

  /// The project for which this page is displayed.
  final AugmentedProject project;

  /// A controller for this widget.
  final ProjectController state;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
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
                              errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) => ClipRRect(
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
          padding: const EdgeInsets.only(
            left: Insets.medium,
            top: Insets.large,
            right: Insets.medium,
            bottom: Insets.xLarge,
          ),
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
    );
  }
}
