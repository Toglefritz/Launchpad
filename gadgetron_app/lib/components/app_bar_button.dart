import 'package:flutter/material.dart';
import 'package:gadgetron_app/theme/insets.dart';


/// A button displayed in the [AppBar].
///
/// These buttons consist of an icon inside a subtle circular border.
class AppBarButton extends StatelessWidget {
  /// Creates an instance of the [AppBarButton] widget.
  const AppBarButton({
    required this.icon,
    required this.onTap,
    super.key,
  });

  /// The icon displayed in the button.
  final Widget icon;

  /// A function called when the button is tapped.
  final void Function() onTap;

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
      child: IconButton(
        icon: icon,
        onPressed: onTap,
      ),
    );
  }
}
