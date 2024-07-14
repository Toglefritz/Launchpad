import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:launchpad_app/firebase_options.dart';
import 'package:launchpad_app/launchpad_app.dart';
import 'package:launchpad_app/services/firebase_core/firebase_emulators_ip.dart';
import 'package:launchpad_app/services/firebase_remote_config/remote_config_service.dart';

/// The main entry point for the Launchpad app.
///
/// The [main] function initializes various Firebase resources before running the [LaunchpadApp] widget.
///
/// An argument can be passed to the `flutter run` command to configure the app to use the Firebase Emulator Suite for
/// some resources. By default, the app does not use the Firebase Emulator Suite because Gemini AI services, which are
/// critical to the app's functionality, are not yet available in the Firebase Emulator Suite. However, other services,
/// such as Firebase Authentication, can be used in the Firebase Emulator Suite. To run the app with the Firebase
/// Emulator Suite, pass the `USE_FIREBASE_EMULATOR=true` argument to the `flutter run` command:
///
/// ```bash
/// flutter run --dart-define=USE_FIREBASE_EMULATOR=true
/// ```
Future<void> main() async {
  // Get the use_emulator boolean from the `flutter run` command to determine if the Firebase Emulator Suite should
  // be used. The `fromEnvironment` method returns false by default if the argument is not passed.
  const bool useFirebaseEmulator = bool.fromEnvironment('USE_FIREBASE_EMULATOR');

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

  // If the app is running in debug mode and the flag to use the Firebase Emulator Suite is set, use the Firebase
  // local emulator so development on some paid Firebase Resources can be done locally, without putting production
  // data (and production billing accounts) at risk.
  if (kDebugMode && useFirebaseEmulator) {
    try {
      await FirebaseAuth.instance.useAuthEmulator(firebaseEmulatorsIp, 9099);

      debugPrint('Using Firebase emulator suite');
    } catch (e) {
      debugPrint('Firebase emulator initialization failed with exception, $e');
    }
  }

  // TODO(Toglefritz): Make Crashlytics be happening
  /*if (!kDebugMode) {
    // Pass all uncaught "fatal" errors from the framework to Crashlytics
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;

    // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
    PlatformDispatcher.instance.onError = (error, stack) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      return true;
    };
  }*/

  // Initialize the Firebase Remote Config service.
  try {
    final RemoteConfigService remoteConfigService = RemoteConfigService();
    await remoteConfigService.initialize();
  } catch (e) {
    debugPrint('Remote Config initialization failed with exception, $e');

    // TODO(Toglefritz): Handle this exception
  }

  runApp(const LaunchpadApp());
}
