import 'package:flutter/material.dart';
import 'package:gadgetron_app/theme/insets.dart';

/// A custom button widget that mimics the behavior of [ElevatedButton.icon] but ensures that the text style from the
/// theme is applied to the label.
///
/// In Flutter, when using the [ElevatedButton.icon] constructor, the text style defined in the theme is not
/// automatically applied to the label text. This can lead to inconsistencies in the appearance of button text
/// throughout the app. The [PrimaryCTAButton] addresses this issue by explicitly applying the text style from the
/// theme to the label.
///
/// This widget accepts the same parameters as [ElevatedButton.icon] and provides a similar appearance and behavior,
/// ensuring that the text style from the current theme is used for the label text.
///
/// The [PrimaryCTAButton] can also accept a [style] parameter to customize its appearance further. If no [style] is
/// provided, it defaults to using the `ElevatedButton.styleFrom` method with the text style from the theme.
class PrimaryCTAButton extends StatelessWidget {
  /// Called when the button is tapped or otherwise activated.
  final VoidCallback? onPressed;

  /// The icon to display inside the button.
  final Widget icon;

  /// The label to display inside the button.
  final Widget label;

  /// Customizes the appearance of the [DefaultTextStyle] widget that wraps the [label].
  final TextStyle? style;

  /// Creates a [PrimaryCTAButton].
  ///
  /// The [icon] and [label] arguments must not be null.
  const PrimaryCTAButton({
    required this.onPressed,
    required this.icon,
    required this.label,
    super.key,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    // Determine the effective style by merging the provided style with the default
    // ElevatedButton style, ensuring the text style from the theme is applied.
    final TextStyle effectiveStyle =
        style ?? Theme.of(context).elevatedButtonTheme.style?.textStyle?.resolve({}) ?? const TextStyle();

    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Padding(
        padding: const EdgeInsets.only(right: Insets.small),
        child: icon,
      ),
      // Apply the resolved text style to the label using DefaultTextStyle.
      label: DefaultTextStyle(
        style: effectiveStyle,
        child: label,
      ),
    );
  }
}
