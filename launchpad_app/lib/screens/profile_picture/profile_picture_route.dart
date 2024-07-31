import 'package:flutter/material.dart';
import 'package:launchpad_app/screens/account/account_route.dart';
import 'package:launchpad_app/screens/profile_picture/profile_picture_controller.dart';

/// This route displays a selection of profile picture images. The user can select one of these images to use as their
/// profile picture.
///
/// This route is accessible from the [AccountRoute] widget. It displays options for profile pictures based on images
/// that are stored in the app's assets. The app does not currently support uploading custom profile pictures. Once the
/// user selects a profile picture, the file name of that image is passed back to the [AccountRoute] widget, which then
/// displays the selected image as the user's profile picture.
class ProfilePictureRoute extends StatefulWidget {
  /// Creates an instance of the [AccountRoute] widget.
  const ProfilePictureRoute({super.key});

  @override
  ProfilePictureController createState() => ProfilePictureController();
}
