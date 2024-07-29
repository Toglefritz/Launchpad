import 'package:flutter/material.dart';
import 'package:launchpad_app/components/app_bar/app_bar_button.dart';
import 'package:launchpad_app/components/app_bar/app_bar_popup_menu.dart';
import 'package:launchpad_app/components/decorative_background.dart';
import 'package:launchpad_app/screens/project/project_controller.dart';
import 'package:launchpad_app/services/project/augmented_project.dart';
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
        actions: const [
          AppBarPopupMenu(),
        ],
      ),
      body: SafeArea(
        child: CustomScrollView(
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
            if (project.projectImage != null)
              SliverPadding(
                padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.125,
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
                            : Image.network(
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
                      );
                    },
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
