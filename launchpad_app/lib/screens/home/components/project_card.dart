import 'package:flutter/material.dart';
import 'package:launchpad_app/components/image_placeholders/decorative_background.dart';
import 'package:launchpad_app/components/loader/wave_loading_indicator.dart';
import 'package:launchpad_app/services/project/augmented_project.dart';
import 'package:launchpad_app/theme/insets.dart';

/// A card that displays one of the user's projects.
///
/// This card displays the project's name and cover image. If no cover image is available, a decorative background is
/// shown instead.
class ProjectCard extends StatelessWidget {
  /// Creates a [ProjectCard].
  const ProjectCard({
    required this.project,
    super.key,
  });

  /// The project represented by this card.
  final AugmentedProject project;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        // Create a shadow with a hard edge to create a brutalist design.
        Container(
          width: 150.0 - Insets.small,
          height: (130.0 + MediaQuery.textScalerOf(context).scale(16) * 4 + Insets.small * 5) - Insets.large,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).brightness == Brightness.light
                    ? Theme.of(context).primaryColorDark
                    : Colors.black,
              ),
            ],
            borderRadius: BorderRadius.circular(12.0),
          ),
        ),
        Card(
          child: SizedBox(
            width: 150.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                if (project.projectImage != null)
                  Padding(
                    padding: const EdgeInsets.all(Insets.small),
                    child: FutureBuilder(
                      future: project.projectImage?.getImageUrl(),
                      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                        Widget child;
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          child = const WaveLoadingIndicator();
                        } else if (snapshot.data != null) {
                          child = ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.network(
                              snapshot.data!,
                              fit: BoxFit.cover,
                              errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) => ClipRRect(
                                borderRadius: BorderRadius.circular(12.0),
                                child: const SizedBox(
                                  height: 115.0,
                                  child: DecorativeBackground(),
                                ),
                              ),
                            ),
                          );
                        } else {
                          child = ClipRRect(
                            borderRadius: BorderRadius.circular(12.0),
                            child: const SizedBox(
                              height: 115.0,
                              child: DecorativeBackground(),
                            ),
                          );
                        }

                        return AnimatedSwitcher(
                          duration: const Duration(milliseconds: 250),
                          child: child,
                        );
                      },
                    ),
                  ),

                // Show a decorative background element if no background image is available.
                if (project.projectImage == null)
                  Padding(
                    padding: const EdgeInsets.all(Insets.small),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12.0),
                      child: const SizedBox(
                        height: 115.0,
                        child: DecorativeBackground(),
                      ),
                    ),
                  ),

                // Show the project name
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: Insets.small,
                  ),
                  child: Text(
                    project.name,
                    maxLines: 3,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
