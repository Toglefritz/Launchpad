import 'package:flutter/material.dart';
import 'package:launchpad_app/screens/profile_picture/profile_picture_route.dart';
import 'package:launchpad_app/screens/profile_picture/profile_picture_view.dart';
import 'package:launchpad_app/services/firebase_auth/models/profile_picture.dart';

/// A controller for the [ProfilePictureRoute] widget.
class ProfilePictureController extends State<ProfilePictureRoute> {
  /// Handles taps on one of the profile picture options.
  void onImageSelected(ProfilePicture profilePicture) {
    Navigator.pop(context, profilePicture);
  }

  @override
  Widget build(BuildContext context) => ProfilePictureView(this);
}
