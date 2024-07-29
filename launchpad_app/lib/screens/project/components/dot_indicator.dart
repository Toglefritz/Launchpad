import 'package:flutter/material.dart';
import 'package:launchpad_app/theme/insets.dart';

/// A widget that displays a dot-based pagination indicator for a [PageView].
///
/// The [DotIndicator] widget provides a visual indication of the current page within a [PageView], with animated
/// transitions for the active dot. The active dot is slightly larger and uses the color defined by
/// `Theme.of(context).primaryColorDark`, while the inactive dots are smaller and use the color defined by
/// `Theme.of(context).disabledColor`. The size and color changes are animated over a duration of 250 milliseconds.
///
/// This widget is typically used in conjunction with a [PageView] and [PageController] to indicate the current page
/// index.
///
/// The [DotIndicator] widget takes two required parameters:
/// - [currentIndex]: The index of the currently active page.
/// - [itemCount]: The total number of pages.
///
/// The widget builds a row of dots, where the active dot is represented by a larger size and a different color. The
/// changes in size and color are animated to provide a smooth transition effect.
class DotIndicator extends StatelessWidget {
  /// The index of the currently active page.
  final int currentIndex;

  /// The total number of pages.
  final int itemCount;

  /// Creates a [DotIndicator] widget.
  ///
  /// The [currentIndex] and [itemCount] parameters are required.
  const DotIndicator({
    required this.currentIndex,
    required this.itemCount,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(itemCount, (index) {
        final bool isActive = index == currentIndex;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          margin: const EdgeInsets.symmetric(horizontal: Insets.small),
          width: isActive ? 12.0 : 8.0,
          height: isActive ? 12.0 : 8.0,
          decoration: BoxDecoration(
            color: isActive ? Theme.of(context).primaryColorDark : Theme.of(context).disabledColor,
            shape: BoxShape.circle,
          ),
        );
      }),
    );
  }
}
