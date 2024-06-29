import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gadgetron_app/firebase_options.dart';
import 'package:gadgetron_app/gadgetron_app.dart';
import 'package:gadgetron_app/services/firebase_core/firebase_emulators_ip.dart';

/// The main entry point for the Gadgetron app.
///
/// The [main] function initializes Firebase and Firebase AppCheck before running the [GadgetronApp] widget. If the app is
/// running in debug mode, the Firebase local emulator suite is used.
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase services.
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Initialize Firebase AppCheck. AppCheck is used to protect backend resources by ensuring that incoming requests are
  // from an authentic source, such as this app. The AppCheck initialization here enables the backend to verify the
  // authenticity of requests from this app.
  if (kDebugMode) {
    await FirebaseAppCheck.instance.activate(
      androidProvider: AndroidProvider.debug,
      appleProvider: AppleProvider.debug,
    );
  } else {
    await FirebaseAppCheck.instance.activate();
  }

  // In debug mode, use the Firebase local emulator so development can be done locally, without putting production data
  // (and production billing accounts) at risk.
  if (kDebugMode) {
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

  runApp(const GadgetronApp());
}
