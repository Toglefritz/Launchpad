import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:launchpad_app/components/tertiary_cta_button.dart';
import 'package:launchpad_app/screens/home/home_controller.dart';
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
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text(
          AppLocalizations.of(context)!.homeTitle,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontSize: 24,
              ),
        ),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) => state.onLogout(),
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem<String>(
                  value: AppLocalizations.of(context)!.logout,
                  child: Text(
                    AppLocalizations.of(context)!.logout,
                    textAlign: TextAlign.center,
                  ),
                ),
              ];
            },
            icon: Icon(
              Icons.more_vert,
              color: Theme.of(context).primaryColorDark,
            ),
          ),
        ],
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
