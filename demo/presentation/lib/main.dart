import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:launchpad_app/services/firebase_remote_config/remote_config_service.dart';
import 'package:presentation/firebase_options.dart';
import 'package:presentation/launchpad_presentation_app.dart';

/// The main entry point for the Launchpad Presentation app.
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase services.
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // If the app is running in debug mode and the flag to use the Firebase Emulator Suite is set, activate the Firebase
  // App Check debug provider.
  if (kDebugMode) {
    await FirebaseAppCheck.instance.activate(
      androidProvider: AndroidProvider.debug,
      appleProvider: AppleProvider.debug,
    );
  } else {
    await FirebaseAppCheck.instance.activate();
  }

  // Initialize the Firebase Remote Config service.
  try {
    final RemoteConfigService remoteConfigService = RemoteConfigService();
    await remoteConfigService.initialize();
  } catch (e) {
    debugPrint('Remote Config initialization failed with exception, $e');

    // TODO(Toglefritz): Handle this exception
  }

  // Set the app to full-screen mode by hiding the status and navigation bars.
  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

  runApp(const LaunchpadPresentationApp());
}
