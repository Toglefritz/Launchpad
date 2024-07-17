import 'package:flutter/material.dart';
import 'package:launchpad_app/screens/home/home_route.dart';
import 'package:launchpad_app/screens/home/home_view.dart';
import 'package:launchpad_app/screens/project_creation/project_creation_route.dart';

/// A controller for the [HomeRoute] widget.
class HomeController extends State<HomeRoute> {
  // TODO(Toglefritz): get a list of the user's in-progress projects

  /// Handles taps on the button used to start the new project flow.
  Future<void> onNewProject() async {
    await Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: (context) => const ProjectCreationRoute(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) => HomeView(this);
}
