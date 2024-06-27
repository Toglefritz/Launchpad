import 'package:flutter/material.dart';

/// This class provides the theme for the Gadgetron app based on the current brightness. Static getters are provided
/// for both light and dark themes.
class GadgetronAppTheme {
  /// [ThemeData] for the app when a light theme is enabled.
  static ThemeData get lightTheme => ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.grey.shade900,
        ),
      );

  /// [ThemeData] for the app when a dark theme is enabled.
  static ThemeData get darkTheme => ThemeData(
        colorScheme: ColorScheme.fromSeed(
          brightness: Brightness.dark,
          seedColor: Colors.grey.shade100,
        ),
      );
}
