import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:launchpad_app/screens/navigation_wrapper/navigation_wrapper_route.dart';
import 'package:launchpad_app/theme/launchpad_app_theme.dart';

/// This widget provides a central [MaterialApp] for the Launchpad app.
///
/// Among other things, this route provides theming for the app via the [LaunchpadAppTheme] class.
class LaunchpadApp extends StatelessWidget {
  /// Creates an instance of the [LaunchpadApp] widget.
  const LaunchpadApp({super.key});

  /// A navigator key for the app.
  static final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  /// A getter for the navigator key. This is used by entities in the app that do not have their own reference to the
  /// build context. Instead, these entities will use this getter to access the navigator key, and use its context.
  static GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Launchpad',
      key: _navigatorKey,
      debugShowCheckedModeBanner: false,
      theme: LaunchpadAppTheme.lightTheme,
      darkTheme: LaunchpadAppTheme.darkTheme,
      highContrastTheme: LaunchpadAppTheme.highContrastLightTheme,
      highContrastDarkTheme: LaunchpadAppTheme.highContrastDarkTheme,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'),
      ],
      home: const NavigationWrapperRoute(),
    );
  }
}
