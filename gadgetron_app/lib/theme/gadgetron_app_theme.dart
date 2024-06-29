import 'package:flutter/material.dart';

import 'package:gadgetron_app/components/dashed_input_border.dart';
import 'package:gadgetron_app/theme/insets.dart';

/// This class provides the theme for the Gadgetron app based on the current brightness. Static getters are provided
/// for both light and dark themes.
class GadgetronAppTheme {
  /// [ThemeData] for the app when a light theme is enabled.
  static ThemeData get lightTheme => ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.grey.shade900,
        ),
        primaryColorLight: Colors.grey.shade100,
        primaryColorDark: Colors.grey.shade900,
        scaffoldBackgroundColor: const Color(0xFFD6D6D6),
        // Set "KodeMono" as the default font for heads in the app.
        textTheme: ThemeData.light().textTheme.copyWith(
              displayLarge: ThemeData.light().textTheme.displayLarge?.copyWith(
                    fontFamily: 'KodeMono',
                    fontWeight: FontWeight.bold,
                  ),
              displayMedium: ThemeData.light().textTheme.displayMedium?.copyWith(
                    fontFamily: 'KodeMono',
                    fontWeight: FontWeight.bold,
                  ),
              displaySmall: ThemeData.light().textTheme.displaySmall?.copyWith(
                    fontFamily: 'KodeMono',
                    fontWeight: FontWeight.bold,
                  ),
              headlineLarge: ThemeData.light().textTheme.headlineLarge?.copyWith(
                    fontFamily: 'KodeMono',
                    fontWeight: FontWeight.bold,
                  ),
              headlineMedium: ThemeData.light().textTheme.headlineMedium?.copyWith(
                    fontFamily: 'KodeMono',
                    fontWeight: FontWeight.bold,
                  ),
              headlineSmall: ThemeData.light().textTheme.headlineSmall?.copyWith(
                    fontFamily: 'KodeMono',
                    fontWeight: FontWeight.bold,
                  ),
            ),
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: Colors.grey.shade900,
          selectionColor: Colors.grey.shade900.withOpacity(0.5),
          selectionHandleColor: Colors.grey.shade900,
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: DashedInputBorder(
            color: Colors.grey.shade900,
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: Insets.medium,
            vertical: Insets.medium,
          ),
          filled: true,
          fillColor: Colors.grey.shade100,
          labelStyle: ThemeData.light().textTheme.bodyMedium?.copyWith(
                color: Colors.grey.shade900,
              ),
          floatingLabelStyle: ThemeData.light().textTheme.bodyMedium?.copyWith(
                color: Colors.grey.shade900,
                backgroundColor: Colors.grey.shade50,
              ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(Colors.grey.shade900),
            foregroundColor: WidgetStateProperty.all(Colors.grey.shade100),
            shape: WidgetStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
            ),
            textStyle: WidgetStateProperty.all(
              ThemeData.light().textTheme.headlineSmall?.copyWith(
                    color: Colors.grey.shade100,
                    fontFamily: 'KodeMono',
                    fontWeight: FontWeight.bold,
                  ),
            ),
            iconColor: WidgetStateProperty.all(Colors.grey.shade100),
            minimumSize: WidgetStateProperty.all(
              const Size(200.0, 56.0),
            ),
          ),
        ),
      );

  /// [ThemeData] for the app when a dark theme is enabled.
  static ThemeData get darkTheme => ThemeData(
        colorScheme: ColorScheme.fromSeed(
          brightness: Brightness.dark,
          seedColor: Colors.grey.shade100,
        ),

        primaryColorLight: Colors.grey.shade900,

        primaryColorDark: Colors.grey.shade100,

        // Set "KodeMono" as the default font for heads in the app.
        textTheme: ThemeData.light().textTheme.copyWith(
              displayLarge: ThemeData.light().textTheme.displayLarge?.copyWith(
                    fontFamily: 'KodeMono',
                    color: Colors.grey.shade100,
                    fontWeight: FontWeight.bold,
                  ),
              displayMedium: ThemeData.light().textTheme.displayMedium?.copyWith(
                    fontFamily: 'KodeMono',
                    color: Colors.grey.shade100,
                  ),
              displaySmall: ThemeData.light().textTheme.displaySmall?.copyWith(
                    fontFamily: 'KodeMono',
                    color: Colors.grey.shade100,
                    fontWeight: FontWeight.bold,
                  ),
              headlineLarge: ThemeData.light().textTheme.headlineLarge?.copyWith(
                    fontFamily: 'KodeMono',
                    color: Colors.grey.shade100,
                    fontWeight: FontWeight.bold,
                  ),
              headlineMedium: ThemeData.light().textTheme.headlineMedium?.copyWith(
                    fontFamily: 'KodeMono',
                    color: Colors.grey.shade100,
                    fontWeight: FontWeight.bold,
                  ),
              headlineSmall: ThemeData.light().textTheme.headlineSmall?.copyWith(
                    fontFamily: 'KodeMono',
                    color: Colors.grey.shade100,
                    fontWeight: FontWeight.bold,
                  ),
            ),
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: Colors.grey.shade100,
          selectionColor: Colors.grey.shade100.withOpacity(0.5),
          selectionHandleColor: Colors.grey.shade100,
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: DashedInputBorder(
            color: Colors.grey.shade100,
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: Insets.medium,
            vertical: Insets.medium,
          ),
          filled: true,
          fillColor: Colors.grey.shade900,
          labelStyle: ThemeData.light().textTheme.bodyMedium?.copyWith(
                color: Colors.grey.shade100,
              ),
          floatingLabelStyle: ThemeData.light().textTheme.bodyMedium?.copyWith(
                color: Colors.grey.shade100,
                backgroundColor: Colors.grey.shade900,
              ),
        ),
      );

  /// [ThemeData] for the app when a high contrast light theme is enabled.
  static ThemeData get highContrastLightTheme => lightTheme.copyWith(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.black,
        ),
        primaryColorLight: Colors.black,
        primaryColorDark: Colors.black,
        scaffoldBackgroundColor: Colors.white,
        textTheme: ThemeData.light().textTheme.copyWith(
              displayLarge: ThemeData.light().textTheme.displayLarge?.copyWith(
                    color: Colors.black,
                  ),
              displayMedium: ThemeData.light().textTheme.displayMedium?.copyWith(
                    color: Colors.black,
                  ),
              displaySmall: ThemeData.light().textTheme.displaySmall?.copyWith(
                    color: Colors.black,
                  ),
              headlineLarge: ThemeData.light().textTheme.headlineLarge?.copyWith(
                    color: Colors.black,
                  ),
              headlineMedium: ThemeData.light().textTheme.headlineMedium?.copyWith(
                    color: Colors.black,
                  ),
              headlineSmall: ThemeData.light().textTheme.headlineSmall?.copyWith(
                    color: Colors.black,
                  ),
            ),
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: Colors.black,
          selectionColor: Colors.black.withOpacity(0.5),
          selectionHandleColor: Colors.black,
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: const DashedInputBorder(),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: Insets.medium,
            vertical: Insets.medium,
          ),
          filled: true,
          fillColor: Colors.white,
          labelStyle: ThemeData.light().textTheme.bodyMedium?.copyWith(
                color: Colors.black,
              ),
          floatingLabelStyle: ThemeData.light().textTheme.bodyMedium?.copyWith(
                color: Colors.black,
                backgroundColor: Colors.white,
              ),
        ),
      );

  /// [ThemeData] for the app when a high contrast dark theme is enabled.
  static ThemeData get highContrastDarkTheme => darkTheme.copyWith(
        colorScheme: ColorScheme.fromSeed(
          brightness: Brightness.dark,
          seedColor: Colors.white,
        ),
        primaryColorLight: Colors.white,
        primaryColorDark: Colors.white,
        textTheme: ThemeData.light().textTheme.copyWith(
              displayLarge: ThemeData.light().textTheme.displayLarge?.copyWith(
                    color: Colors.white,
                  ),
              displayMedium: ThemeData.light().textTheme.displayMedium?.copyWith(
                    color: Colors.white,
                  ),
              displaySmall: ThemeData.light().textTheme.displaySmall?.copyWith(
                    color: Colors.white,
                  ),
              headlineLarge: ThemeData.light().textTheme.headlineLarge?.copyWith(
                    color: Colors.white,
                  ),
              headlineMedium: ThemeData.light().textTheme.headlineMedium?.copyWith(
                    color: Colors.white,
                  ),
              headlineSmall: ThemeData.light().textTheme.headlineSmall?.copyWith(
                    color: Colors.white,
                  ),
            ),
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: Colors.white,
          selectionColor: Colors.white.withOpacity(0.5),
          selectionHandleColor: Colors.white,
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: const DashedInputBorder(),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: Insets.medium,
            vertical: Insets.medium,
          ),
          filled: true,
          fillColor: Colors.black,
          labelStyle: ThemeData.light().textTheme.bodyMedium?.copyWith(
                color: Colors.white,
              ),
          floatingLabelStyle: ThemeData.light().textTheme.bodyMedium?.copyWith(
                color: Colors.white,
                backgroundColor: Colors.black,
              ),
        ),
      );
}
