import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:gadgetron_app/screens/project_search/project_search_controller.dart';
import 'package:gadgetron_app/theme/insets.dart';

/// A view for the [ProjectSearchController] widget.
class ProjectSearchView extends StatelessWidget {
  /// A controller for this view.
  final ProjectSearchController state;

  /// Creates an instance of the [ProjectSearchView] widget.
  const ProjectSearchView(
    this.state, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverPadding(
              padding: const EdgeInsets.all(Insets.medium),
              sliver: SliverToBoxAdapter(
                child: Text(
                  AppLocalizations.of(context)!.projectSearchTitle,
                  style: Theme.of(context).textTheme.headlineSmall,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.all(Insets.medium),
              sliver: SliverToBoxAdapter(
                child: TextField(
                  controller: state.searchController,
                  maxLines: null,
                  minLines: 4,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
