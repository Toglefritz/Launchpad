import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:launchpad_app/screens/account/account_route.dart';
import 'package:launchpad_app/screens/account/account_view.dart';
import 'package:launchpad_app/screens/profile_picture/profile_picture_route.dart';
import 'package:launchpad_app/services/firebase_auth/authentication_service.dart';
import 'package:launchpad_app/services/firebase_auth/models/profile_picture.dart';
import 'package:launchpad_app/services/firebase_auth/user_profile_service.dart';

/// A controller for the [AccountRoute] widget.
class AccountController extends State<AccountRoute> {
  /// The user currently logged in to the app.
  late User user;

  /// Handles requests by the user to change their profile picture.
  ///
  /// When the user taps the button used to change their profile picture, this route will navigate to the profile
  /// picture selection route. If the user selects a new profile picture, this method will update the user's profile
  /// picture, assuming that the user has selected a new profile picture.
  Future<void> onChangePicture() async {
    // Navigate to the profile picture selection route.
    final ProfilePicture? newPicture = await Navigator.push<ProfilePicture>(
      context,
      MaterialPageRoute<ProfilePicture>(
        builder: (context) => const ProfilePictureRoute(),
      ),
    );

    // If the user selected a new profile picture, update the user's profile picture.
    if (newPicture != null && newPicture != UserProfileService.profilePictureNotifier.value) {
      // Rebuild the UI to immediately reflect the new profile picture.
      setState(() {
        UserProfileService.profilePictureNotifier.value = newPicture;
      });

      // Get an App Check token.
      final String? appCheckToken = await FirebaseAppCheck.instance.getToken();
      if (appCheckToken == null) {
        // TODO(Toglefritz): Handle this error.
        return;
      }

      // Update the user's profile picture in Firestore.
      await UserProfileService.setProfilePicture(
        newPicture: newPicture,
        user: user,
        appCheckToken: appCheckToken,
      );
    }
  }

  @override
  void initState() {
    // Get the current user from the authentication service.
    user = FirebaseAuth.instance.currentUser!;

    super.initState();
  }

  /// Handles requests by the user to log out of the app, a process initialized by taps on the "Logout" button in this
  /// route.
  void onLogout() {
    AuthenticationService.signOut();
  }

  @override
  Widget build(BuildContext context) => AccountView(this);
}
