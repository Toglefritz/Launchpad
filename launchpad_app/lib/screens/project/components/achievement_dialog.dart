import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:launchpad_app/components/buttons/secondary_cta_button.dart';
import 'package:launchpad_app/components/confetti/confetti_cannon.dart';
import 'package:launchpad_app/services/project/models/achievement.dart';
import 'package:launchpad_app/theme/insets.dart';
import 'package:vector_math/vector_math_64.dart';

/// A dialog that displays an achievement.
///
/// This dialog is displayed when a user completes a step of a project that is linked to an achievement. The dialog
/// displays the title and description of the achievement, and provides a button to close the dialog. To add a bit of
/// flair, the dialog also displays confetti.
class AchievementDialog extends StatelessWidget {
  /// The achievement to display in the dialog.
  const AchievementDialog({
    required this.achievement,
    super.key,
  });

  /// The achievement to display in the dialog.
  final Achievement achievement;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AlertDialog(
          title: Text(
            achievement.title,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(achievement.description),
              Padding(
                padding: const EdgeInsets.only(
                  top: Insets.medium,
                ),
                child: SecondaryCTAButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Icons.celebration),
                  label: Text(
                    AppLocalizations.of(context)!.achievementCloseButton.toUpperCase(),
                  ),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: 0,
          right: 0,
          child: ConfettiCannon(
            duration: const Duration(seconds: 8),
            direction: Vector2(-sqrt(2) / 2, sqrt(2) / 2),
            randomness: 0.8,
            spread: pi / 3,
          ),
        ),
        Positioned(
          top: 0,
          left: 0,
          child: ConfettiCannon(
            duration: const Duration(seconds: 8),
            direction: Vector2(sqrt(2) / 2, sqrt(2) / 2),
            randomness: 0.8,
            spread: pi / 3,
          ),
        ),
      ],
    );
  }
}
