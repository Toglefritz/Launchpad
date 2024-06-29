import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:gadgetron_app/screens/navigation_wrapper/navigation_wrapper_route.dart';
import 'package:gadgetron_app/theme/gadgetron_app_theme.dart';

/// This widget provides a central [MaterialApp] for the Gadgetron app.
///
/// Among other things, this route provides theming for the app via the [GadgetronAppTheme] class.
class GadgetronApp extends StatelessWidget {
  /// Creates an instance of the [GadgetronApp] widget.
  const GadgetronApp({super.key});

  /// A navigator key for the app.
  static final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  /// A getter for the navigator key. This is used by entities in the app that do not have their own reference to the
  /// build context. Instead, these entities will use this getter to access the navigator key, and use its context.
  static GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gadgetron',
      key: _navigatorKey,
      debugShowCheckedModeBanner: false,
      theme: GadgetronAppTheme.lightTheme,
      darkTheme: GadgetronAppTheme.darkTheme,
      highContrastTheme: GadgetronAppTheme.highContrastLightTheme,
      highContrastDarkTheme: GadgetronAppTheme.highContrastDarkTheme,
      localizationsDelegates: const [
        AppLocalizations.delegate,
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
