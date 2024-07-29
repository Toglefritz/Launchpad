import 'package:flutter/material.dart';
import 'package:launchpad_app/theme/insets.dart';

/// A menu button displayed in the [AppBar].
///
/// This button consists of an icon that, when tapped, displays a popup menu with a list of options. The icon is
/// displayed inside a subtle circular border.
class AppBarPopupMenu extends StatelessWidget {
  /// Creates an instance of the [AppBarPopupMenu] widget.
  const AppBarPopupMenu({
    required this.items,
    super.key,
  });

  /// A list of items to display in the popup menu.
  final List<PopupMenuItem<void Function()>> items;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(Insets.small),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: Theme.of(context).dividerColor,
        ),
      ),
      child: PopupMenuButton<void Function()>(
        onSelected: (void Function() callback) => callback(),
        itemBuilder: (BuildContext context) {
          return items;
        },
        icon: Icon(
          Icons.more_vert,
          color: Theme.of(context).primaryColorDark,
        ),
      ),
    );
  }
}
