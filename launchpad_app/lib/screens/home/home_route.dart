import 'package:flutter/material.dart';
import 'package:launchpad_app/screens/home/home_controller.dart';

/// This route is the "home" screen of the application.
///
/// This route is the first screen an authenticated user sees when they open the application and the first screen
/// presented to users after they log in or create an account. This screen shows a list of in-progress projects for the
/// current user (assuming they have any) and allows the user to start new projects. Additionally, this screen lists
/// the most recent achievements earned by the user.
class HomeRoute extends StatefulWidget {
  /// Creates an instance of the [HomeRoute] widget.
  const HomeRoute({super.key});

  @override
  State<HomeRoute> createState() => HomeController();
}
