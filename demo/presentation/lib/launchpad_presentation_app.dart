import 'package:flutter/material.dart';
import 'package:launchpad_app/theme/launchpad_app_theme.dart';
import 'package:presentation/screens/presentation_wrapper/presentation_wrapper_route.dart';

/// This widget provides a central [MaterialApp] for the Launchpad app.
///
/// Among other things, this route provides theming for the app. It does this by using the [LaunchpadAppTheme] class to
/// provide theming for the app, and to provide a consistent look and feel across the app and the presentation.
class LaunchpadPresentationApp extends StatelessWidget {
  const LaunchpadPresentationApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Launchpad App Demo',
      debugShowCheckedModeBanner: false,
      // The presentation app uses the LaunchpadAppTheme class to provide theming for the app and provide a consistent
      // look and feel across the app and the presentation.
      theme: LaunchpadAppTheme.lightTheme,
      darkTheme: LaunchpadAppTheme.darkTheme,
      highContrastTheme: LaunchpadAppTheme.highContrastLightTheme,
      highContrastDarkTheme: LaunchpadAppTheme.highContrastDarkTheme,
      home: const PresentationWrapperRoute(),
    );
  }
}