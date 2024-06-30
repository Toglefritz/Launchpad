import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gadgetron_app/screens/navigation_wrapper/models/navigation_bar_item.dart';
import 'package:gadgetron_app/screens/navigation_wrapper/navigation_wrapper_route.dart';
import 'package:gadgetron_app/screens/navigation_wrapper/navigation_wrapper_view.dart';
import 'package:gadgetron_app/screens/onboarding/onboarding_route.dart';
import 'package:gadgetron_app/screens/project_search/project_search_route.dart';

/// A controller for the [NavigationWrapperRoute] widget.
///
/// The [StreamBuilder] widget listens for changes in the user's authentication state. If the user is authenticated, the
/// [NavigationWrapperView] will be displayed. If the user is not authenticated, the [OnboardingRoute] will be
/// displayed.
///
/// The use of this stream means that the app does not perform any navigation calls after the user completes
/// authentication. Instead, the app listens for changes in the authentication state and displays the appropriate
/// page based on the user's authentication status.
class NavigationWrapperController extends State<NavigationWrapperRoute> {
  /// A map of the screens that use the bottom navigation bar.
  ///
  /// Each of these screens is associated with and mapped from a [NavigationBarItem]. Assuming that the user is
  /// authenticated, these screens will be presented within this route in a [IndexedStack] widget, which is a child of a
  /// [Scaffold]. When different items in the bottom navigation bar are selected, the corresponding screen will be
  /// displayed.
  late Map<NavigationBarItem, Widget> _children;

  /// The index of the screen that is currently being displayed.
  NavigationBarItem _currentItem = NavigationBarItem.projectSearch;

  /// A getter that returns the positional index of the [_currentItem] in the [_children] map. In other words, this
  /// is the index of the currently active page in terms of its position in the list of keys for the [_children] map.
  int get currentIndex => _children.keys.toList().indexOf(_currentItem);

  /// Returns a list of [NavigationBarItem]s that correspond to the widgets displayed within this route.
  List<NavigationBarItem> get items => _children.keys.toList();

  /// Returns a list of widgets that will be displayed within this route. This is a list of values from the [_children].
  List<Widget> get children => _children.values.toList();

  @override
  void initState() {
    // Initialize the map of screens that use the bottom navigation bar.
    _initChildren();

    super.initState();
  }

  /// Initializes the map of screens that use the bottom navigation bar. These screens are presented within an
  /// [IndexedStack] widget where the item being displayed is determined by the index of the [IndexedStack] widget.
  void _initChildren() {
    _children = <NavigationBarItem, Widget>{
      NavigationBarItem.projectSearch: const ProjectSearchRoute(),
      NavigationBarItem.projectTroubleshooting: const Placeholder(),
    };
  }

  /// Handles taps on items in the bottom navigation bar by updating the [_currentItem] to the index of the selected
  /// item in the bottom navigation bar.
  void onDestinationSelected(NavigationBarItem item) {
    setState(() {
      _currentItem = item;
    });
  }

  @override
  Widget build(BuildContext context) => StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, AsyncSnapshot<User?> authStateSnapshot) {
          if (authStateSnapshot.hasData) {
            return NavigationWrapperView(this);
          }
          return const OnboardingRoute();
        },
      );
}
