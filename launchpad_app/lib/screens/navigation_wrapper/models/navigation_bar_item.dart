import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:launchpad_app/screens/home/home_route.dart';
import 'package:launchpad_app/screens/navigation_wrapper/navigation_wrapper_route.dart';

/// An enumeration of the screens that use the bottom navigation bar and are presented within the
/// [NavigationWrapperRoute].
///
/// Each item in this enumeration corresponds to a screen that is displayed within the [NavigationWrapperRoute] widget.
/// Each item includes an icon and a label that are used in a [NavigationBar] widget to display the item. Because items
/// in an enum require constant values, getters are used to return the label and icon for each item since the former
/// uses the 'Application' class and the latter uses the 'Icon' class.
enum NavigationBarItem {
  /// The [HomeRoute] screen.
  home,

  /// The ... screen.
  // TODO(Toglefritz): Implement this item. It is here for now because the NavigationBar needs at least two items.
  account;

  /// Returns the label for the item.
  String label(BuildContext context) {
    switch (this) {
      case NavigationBarItem.home:
        return AppLocalizations.of(context)!.homeLabel;
      case NavigationBarItem.account:
        return AppLocalizations.of(context)!.accountLabel;
    }
  }

  /// Returns the icon for the item when the corresponding menu item is selected.
  Icon get icon {
    switch (this) {
      case NavigationBarItem.home:
        return const Icon(Icons.rocket);
      case NavigationBarItem.account:
        return const Icon(Icons.account_circle);
    }
  }

  /// Returns the icon to use for item when the corresponding menu item is not selected.
  Icon get inactiveIcon {
    switch (this) {
      case NavigationBarItem.home:
        return const Icon(Icons.rocket_outlined);
      case NavigationBarItem.account:
        return const Icon(Icons.account_circle_outlined);
    }
  }
}
