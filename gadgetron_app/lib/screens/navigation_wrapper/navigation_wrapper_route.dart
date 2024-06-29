import 'package:flutter/material.dart';
import 'package:gadgetron_app/screens/navigation_wrapper/navigation_wrapper_controller.dart';

/// This widget is used for pages that have a bottom navigation bar and/or require authentication. This widget has
/// two purposes:
///
///   1.  Listen to changes in the authentication state and display the appropriate page depending upon whether or not
///       the user is authenticated.
///   2.  Display a bottom navigation bar in such a way that it remains in place when navigating among child pages.
///
/// There are two different types of navigation performed by different routes in the app, where any given route may
/// use either or both types. The first type is navigation via the bottom navigation bar, which is used by the
/// [NavigationWrapperRoute] and its children. The second type is navigation via the [Navigator] widget provided by
/// the [MaterialApp] widget, which is used by all routes in the app.
///
/// For screens that use the bottom navigation bar, the [NavigationWrapperRoute] is used to allow the bottom navigation
/// bar to remain in place when navigating among pages within the [NavigationWrapperRoute]. This prevents the bottom
/// navigation bar from being rebuilt when navigating among pages, which has the effect of making the bottom navigation
/// bar disappear and reappear when page transitions occur.
///
/// This screen uses an [IndexedStack] widget to display the pages associated with the bottom navigation bar. When
/// different items in the bottom navigation bar are selected, the corresponding screen will be displayed. But note that
/// navigation is not being performed among these pages per se. Instead, the pages are being displayed and hidden by
/// changing the index of the [IndexedStack] widget. Furthermore, using an [IndexedStack] widget allows the pages to
/// maintain their state when they are hidden, which is not the case when using a [Navigator] widget, assuming the
/// pages are disposed when navigating.
///
/// Another component of the navigation systems is displaying the appropriate page based on the authentication state.
/// If a user is not authenticated, the [OnboardingRoute] will be displayed. If a user is authenticated, the
/// [NavigationWrapperRoute] will be displayed. This is accomplished by using a [StreamBuilder] widget that listens
/// to changes in the authentication state.
class NavigationWrapperRoute extends StatefulWidget {
  /// Creates an instance of the [NavigationWrapperRoute] widget.
  const NavigationWrapperRoute({super.key});

  @override
  State<NavigationWrapperRoute> createState() => NavigationWrapperController();
}
