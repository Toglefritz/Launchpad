import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:launchpad_app/components/app_bar/app_bar_button.dart';
import 'package:launchpad_app/components/app_bar/app_bar_popup_menu.dart';
import 'package:launchpad_app/components/buttons/primary_cta_button.dart';
import 'package:launchpad_app/screens/project_creation/project_creation_controller.dart';
import 'package:launchpad_app/theme/insets.dart';

/// A view for the [ProjectCreationController] widget.
class ProjectCreationView extends StatelessWidget {
  /// A controller for this view.
  final ProjectCreationController state;

  /// Creates an instance of the [ProjectCreationView] widget.
  const ProjectCreationView(
    this.state, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        leading: AppBarButton(
          icon: const Icon(Icons.arrow_back),
          onTap: () => Navigator.pop(context),
        ),
        title: Text(
          AppLocalizations.of(context)!.homeTitle,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontSize: 24,
              ),
        ),
        actions: const [
          AppBarPopupMenu(),
        ],
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverPadding(
              padding: const EdgeInsets.all(Insets.medium),
              sliver: SliverToBoxAdapter(
                child: Text(
                  AppLocalizations.of(context)!.projectSearchFieldTitle,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.all(Insets.medium),
              sliver: SliverToBoxAdapter(
                child: TextField(
                  controller: state.searchController,
                  maxLines: null,
                  minLines: 6,
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.all(Insets.medium),
              sliver: SliverToBoxAdapter(
                child: PrimaryCTAButton(
                  onPressed: state.onSearch,
                  icon: const Icon(Icons.bolt),
                  label: Text(AppLocalizations.of(context)!.searchButton.toUpperCase()),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
