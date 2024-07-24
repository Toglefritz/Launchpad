import 'package:flutter/material.dart';
import 'package:launchpad_app/components/app_bar/app_bar_button.dart';
import 'package:launchpad_app/components/app_bar/app_bar_popup_menu.dart';
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
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        leading: AppBarButton(
          icon: const Icon(Icons.arrow_back),
          onTap: () => Navigator.pop(context),
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
            if (project.projectImageUrl != null)
              SliverPadding(
                padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.125,
                ),
                sliver: SliverToBoxAdapter(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12.0),
                    child: Image.network(
                      project.projectImageUrl!,
                      loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                        if (loadingProgress == null) {
                          return child;
                        } else {
                          return CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                                : null,
                          );
                        }
                      },
                      errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
                        return ColoredBox(
                          color: Theme.of(context).colorScheme.secondary,
                          child: const Icon(
                            Icons.no_photography_outlined,
                            size: 42,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
