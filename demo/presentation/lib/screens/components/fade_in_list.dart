import 'package:flutter/material.dart';
import 'package:launchpad_app/theme/insets.dart';

/// A widget that displays a list of strings, revealing each string one by one with a fade-in animation each time the
/// widget is tapped.
///
/// The `FadeInList` widget is ideal for scenarios where you want to present information progressively, allowing the
/// user to discover content step by step. Initially, only the first string in the list is shown. Each subsequent
/// tap reveals the next string with a smooth fade-in effect.
class FadeInList extends StatefulWidget {
  /// The list of strings to display progressively.
  ///
  /// This list contains the content that will be revealed one by one as the user interacts with the widget. The first
  /// item in the list is shown initially, and each tap on the widget reveals the next item with a fade-in effect.
  final List<String> items;

  /// Creates a [FadeInList] widget.
  ///
  /// The [items] parameter is required and must not be null. The list should contain at least one string.
  const FadeInList({
    required this.items,
    super.key,
  });

  @override
  FadeInListState createState() => FadeInListState();
}

/// The state for the [FadeInList] widget.
class FadeInListState extends State<FadeInList> with SingleTickerProviderStateMixin {
  /// Tracks the index of the currently displayed item.
  ///
  /// This integer keeps track of which string in the list is currently being displayed. The index starts at 0 and is
  /// incremented each time the user taps the widget, up to the length of the `items` list.
  int _currentIndex = -1;

  /// Controls the fade-in animation.
  ///
  /// The [AnimationController] manages the animation timing and triggers the fade-in effect when the user taps the
  /// widget. It is initialized with a duration of 500 milliseconds.
  late AnimationController _controller;

  /// Defines the fade-in animation curve.
  ///
  /// The [CurvedAnimation] provides a smooth easing effect for the fade-in transition, making the appearance of the
  /// text more visually appealing.
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );

    // Immediately show the first item in the list in a post frame callback.
    WidgetsBinding.instance.addPostFrameCallback((_) => _showNextItem());
  }

  /// Shows the next item in the list with a fade-in animation.
  ///
  /// This method is called when the user taps the widget. It increments the `_currentIndex` to point to the next
  /// string in the list and triggers the fade-in animation. If the end of the list is reached, no further items
  /// are displayed.
  void _showNextItem() {
    if (_currentIndex < widget.items.length - 1) {
      setState(() {
        _currentIndex++;
      });
      _controller.forward(from: 0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _showNextItem,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(_currentIndex + 1, (index) {
          // Fade in the last item
          if (index == _currentIndex) {
            return FadeTransition(
              opacity: _animation,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 8.0,
                ),
                child: Text(
                  widget.items[index],
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ),
            );
          } else {
            // Show the previous items without animation
            return Padding(
              padding: const EdgeInsets.symmetric(
                vertical: Insets.small,
              ),
              child: Text(
                widget.items[index],
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            );
          }
        }),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
