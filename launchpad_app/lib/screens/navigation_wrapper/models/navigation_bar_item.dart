import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:launchpad_app/screens/navigation_wrapper/navigation_wrapper_route.dart';
import 'package:launchpad_app/screens/project_search/project_search_route.dart';

/// An enumeration of the screens that use the bottom navigation bar and are presented within the
/// [NavigationWrapperRoute].
///
/// Each item in this enumeration corresponds to a screen that is displayed within the [NavigationWrapperRoute] widget.
/// Each item includes an icon and a label that are used in a [NavigationBar] widget to display the item. Because items
/// in an enum require constant values, getters are used to return the label and icon for each item since the former
/// uses the 'Application' class and the latter uses the 'Icon' class.
enum NavigationBarItem {
  /// The [ProjectSearchRoute] screen.
  projectSearch,

  /// Project troubleshooting screen.
  // TODO(Toglefritz): Implement this item. It is here for now because the NavigationBar needs at least two items.
  projectTroubleshooting;

  /// Returns the label for the item.
  String label(BuildContext context) {
    switch (this) {
      case NavigationBarItem.projectSearch:
        return AppLocalizations.of(context)!.projectSearchLabel;
      case NavigationBarItem.projectTroubleshooting:
        return AppLocalizations.of(context)!.projectTroubleshootingLabel;
    }
  }

  /// Returns the icon for the item.
  Icon get icon {
    switch (this) {
      case NavigationBarItem.projectSearch:
        return const Icon(Icons.search);
      case NavigationBarItem.projectTroubleshooting:
        return const Icon(Icons.camera_alt_outlined);
    }
  }
}
