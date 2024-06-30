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
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.grey.shade200,
          foregroundColor: Colors.grey.shade900,
          scrolledUnderElevation: 0.0,
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
          errorStyle: ThemeData.light().textTheme.bodyMedium?.copyWith(
                color: Colors.red.shade900,
              ),
        ),
        // Creates a button with a dark background a light text and icon.
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
        // Creates a button with a neobrutalist design, featuring a dark, hard-edge shadow and a dark border.
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(Colors.grey.shade100),
            foregroundColor: WidgetStateProperty.all(Colors.grey.shade900),
            side: WidgetStateProperty.all(BorderSide(color: Colors.grey.shade900)),
            shape: WidgetStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
            ),
            // The shadow will be created in a custom button widget.
            elevation: WidgetStateProperty.all(0),
            padding: WidgetStateProperty.all(
              const EdgeInsets.symmetric(vertical: Insets.medium, horizontal: Insets.large),
            ),
            textStyle: WidgetStateProperty.all(
              ThemeData.light().textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade900,
                  ),
            ),
            minimumSize: WidgetStateProperty.all(
              const Size(200.0, 56.0),
            ),
            visualDensity: VisualDensity.compact,
          ),
        ),
        chipTheme: ChipThemeData(
          backgroundColor: Colors.grey.shade100,
          disabledColor: Colors.grey.shade500,
          selectedColor: Colors.grey.shade100,
          secondarySelectedColor: Colors.grey.shade100,
          labelStyle: ThemeData.light().textTheme.bodyMedium?.copyWith(
                color: Colors.grey.shade900,
              ),
          secondaryLabelStyle: ThemeData.light().textTheme.bodyMedium?.copyWith(
                color: Colors.grey.shade900,
              ),
          side: BorderSide.none,
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
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.grey.shade800,
          foregroundColor: Colors.grey.shade100,
          scrolledUnderElevation: 0.0,
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
          errorStyle: ThemeData.light().textTheme.bodyMedium?.copyWith(
                color: Colors.red.shade900,
              ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(Colors.grey.shade300),
            foregroundColor: WidgetStateProperty.all(Colors.grey.shade900),
            shape: WidgetStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
            ),
            textStyle: WidgetStateProperty.all(
              ThemeData.dark().textTheme.headlineSmall?.copyWith(
                    color: Colors.grey.shade900,
                    fontFamily: 'KodeMono',
                    fontWeight: FontWeight.bold,
                  ),
            ),
            iconColor: WidgetStateProperty.all(Colors.grey.shade300),
            minimumSize: WidgetStateProperty.all(
              const Size(200.0, 56.0),
            ),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(Colors.grey.shade900),
            foregroundColor: WidgetStateProperty.all(Colors.grey.shade100),
            side: WidgetStateProperty.all(BorderSide(color: Colors.grey.shade100)),
            shape: WidgetStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
            ),
            // The shadow will be created in a custom button widget.
            elevation: WidgetStateProperty.all(0),
            padding: WidgetStateProperty.all(
              const EdgeInsets.symmetric(vertical: Insets.medium, horizontal: Insets.large),
            ),
            textStyle: WidgetStateProperty.all(
              ThemeData.light().textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade100,
                  ),
            ),
            minimumSize: WidgetStateProperty.all(
              const Size(200.0, 56.0),
            ),
            visualDensity: VisualDensity.compact,
          ),
        ),
        chipTheme: ChipThemeData(
          backgroundColor: Colors.grey.shade900,
          disabledColor: Colors.grey.shade500,
          selectedColor: Colors.grey.shade900,
          secondarySelectedColor: Colors.grey.shade900,
          labelStyle: ThemeData.light().textTheme.bodyMedium?.copyWith(
                color: Colors.grey.shade100,
              ),
          secondaryLabelStyle: ThemeData.light().textTheme.bodyMedium?.copyWith(
                color: Colors.grey.shade100,
              ),
          side: BorderSide.none,
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
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          scrolledUnderElevation: 0.0,
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
          errorStyle: ThemeData.light().textTheme.bodyMedium?.copyWith(
                color: Colors.red.shade900,
              ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(Colors.black),
            foregroundColor: WidgetStateProperty.all(Colors.white),
            shape: WidgetStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
            ),
            textStyle: WidgetStateProperty.all(
              ThemeData.light().textTheme.headlineSmall?.copyWith(
                    color: Colors.white,
                    fontFamily: 'KodeMono',
                    fontWeight: FontWeight.bold,
                  ),
            ),
            iconColor: WidgetStateProperty.all(Colors.white),
            minimumSize: WidgetStateProperty.all(
              const Size(200.0, 56.0),
            ),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(Colors.white),
            foregroundColor: WidgetStateProperty.all(Colors.black),
            side: WidgetStateProperty.all(const BorderSide()),
            shape: WidgetStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
            ),
            // The shadow will be created in a custom button widget.
            elevation: WidgetStateProperty.all(0),
            padding: WidgetStateProperty.all(
              const EdgeInsets.symmetric(vertical: Insets.medium, horizontal: Insets.large),
            ),
            textStyle: WidgetStateProperty.all(
              ThemeData.light().textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
            ),
            minimumSize: WidgetStateProperty.all(
              const Size(200.0, 56.0),
            ),
            visualDensity: VisualDensity.compact,
          ),
        ),
        chipTheme: ChipThemeData(
          backgroundColor: Colors.black,
          disabledColor: Colors.grey,
          selectedColor: Colors.black,
          secondarySelectedColor: Colors.black,
          labelStyle: ThemeData.light().textTheme.bodyMedium?.copyWith(
                color: Colors.white,
              ),
          secondaryLabelStyle: ThemeData.light().textTheme.bodyMedium?.copyWith(
                color: Colors.white,
              ),
          side: BorderSide.none,
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
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          scrolledUnderElevation: 0.0,
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
          errorStyle: ThemeData.light().textTheme.bodyMedium?.copyWith(
                color: Colors.red.shade900,
              ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(Colors.white),
            foregroundColor: WidgetStateProperty.all(Colors.black),
            shape: WidgetStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
            ),
            textStyle: WidgetStateProperty.all(
              ThemeData.dark().textTheme.headlineSmall?.copyWith(
                    color: Colors.black,
                    fontFamily: 'KodeMono',
                    fontWeight: FontWeight.bold,
                  ),
            ),
            iconColor: WidgetStateProperty.all(Colors.black),
            minimumSize: WidgetStateProperty.all(
              const Size(200.0, 56.0),
            ),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(Colors.black),
            foregroundColor: WidgetStateProperty.all(Colors.white),
            side: WidgetStateProperty.all(const BorderSide(color: Colors.white)),
            shape: WidgetStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
            ),
            // The shadow will be created in a custom button widget.
            elevation: WidgetStateProperty.all(0),
            padding: WidgetStateProperty.all(
              const EdgeInsets.symmetric(vertical: Insets.medium, horizontal: Insets.large),
            ),
            textStyle: WidgetStateProperty.all(
              ThemeData.light().textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
            ),
            minimumSize: WidgetStateProperty.all(
              const Size(200.0, 56.0),
            ),
            visualDensity: VisualDensity.compact,
          ),
        ),
        chipTheme: ChipThemeData(
          backgroundColor: Colors.white,
          disabledColor: Colors.grey,
          selectedColor: Colors.white,
          secondarySelectedColor: Colors.white,
          labelStyle: ThemeData.light().textTheme.bodyMedium?.copyWith(
                color: Colors.black,
              ),
          secondaryLabelStyle: ThemeData.light().textTheme.bodyMedium?.copyWith(
                color: Colors.black,
              ),
          side: BorderSide.none,
        ),
      );
}
