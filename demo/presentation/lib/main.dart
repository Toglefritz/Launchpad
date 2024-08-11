import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:presentation/launchpad_presentation_app.dart';

/// The main entry point for the Launchpad Presentation app.
void main() {
  // Ensure that plugin services are initialized so that SystemChrome can be used.
  WidgetsFlutterBinding.ensureInitialized();

  // Set the app to full-screen mode by hiding the status and navigation bars.
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

  runApp(const LaunchpadPresentationApp());
}
