import 'package:flutter/material.dart';
import 'package:gadgetron_app/screens/navigation_wrapper/navigation_wrapper_controller.dart';

/// A view for the [NavigationWrapperController] widget.
class NavigationWrapperView extends StatelessWidget {
  /// A controller for this view.
  final NavigationWrapperController state;

  /// Creates an instance of the [NavigationWrapperView] widget.
  const NavigationWrapperView(
    this.state, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: state.currentIndex,
        children: state.children,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: Theme.of(context).dividerColor,
            ),
          ),
        ),
        child: NavigationBar(
          selectedIndex: state.currentIndex,
          onDestinationSelected: (int index) => state.onDestinationSelected(state.items[index]),
          destinations: List.generate(
            state.children.length,
            (int index) => NavigationDestination(
              icon: state.items[index].icon,
              label: state.items[index].label(context),
            ),
          ),
        ),
      ),
    );
  }
}
