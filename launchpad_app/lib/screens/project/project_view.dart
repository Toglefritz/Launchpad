import 'package:flutter/material.dart';
import 'package:launchpad_app/components/app_bar/app_bar_button.dart';
import 'package:launchpad_app/components/app_bar/app_bar_popup_menu.dart';
import 'package:launchpad_app/screens/project/project_controller.dart';
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
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        leading: AppBarButton(
          icon: const Icon(Icons.arrow_back),
          onTap: () => Navigator.pop(context),
        ),
        title: Text(
          'Project Title',  // TODO(Toglefritz): Update this text
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontSize: 24,
              ),
        ),
        actions: const [
          AppBarPopupMenu(),
        ],
      ),
      body: const SafeArea(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverPadding(
              padding: EdgeInsets.all(Insets.medium),
              sliver: SliverToBoxAdapter(
                child: Placeholder(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
