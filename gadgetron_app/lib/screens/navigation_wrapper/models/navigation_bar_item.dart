import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:gadgetron_app/gadgetron_app.dart';
import 'package:gadgetron_app/screens/navigation_wrapper/navigation_wrapper_route.dart';
import 'package:gadgetron_app/screens/project_search/project_search_route.dart';

/// An enumeration of the screens that use the bottom navigation bar and are presented within the
/// [NavigationWrapperRoute].
///
/// Each item in this enumeration corresponds to a screen that is displayed within the [NavigationWrapperRoute] widget.
/// Each item includes an icon and a label that are used in a [NavigationBar] widget to display the item. Because items
/// in an enum require constant values, getters are used to return the label and icon for each item since the former
/// uses the 'Application' class and the latter uses the 'Icon' class.
enum NavigationBarItem {
  /// The [ProjectSearchRoute] screen.
  projectSearch;

  /// Returns the label for the item.
  String get label {
    try {
      switch (this) {
        case NavigationBarItem.projectSearch:
          return AppLocalizations.of(GadgetronApp.navigatorKey.currentContext!)!.projectSearchLabel;
      }
    } catch (e) {
      // If this exception is thrown, it means that either the GadgertronApp.navigatorKey.currentContext is null or the
      // AppLocalizations.of(GadgetronApp.navigatorKey.currentContext!) is null. In either case, we have bigger
      // problems but this getter returns an empty string to avoid a null pointer exception.
      return '';
    }
  }

  /// Returns the icon for the item.
  Icon get icon {
    switch (this) {
      case NavigationBarItem.projectSearch:
        return const Icon(
          Icons.search,
        );
    }
  }
}
