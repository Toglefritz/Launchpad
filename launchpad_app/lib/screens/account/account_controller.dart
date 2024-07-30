import 'package:flutter/material.dart';
import 'package:launchpad_app/screens/account/account_route.dart';
import 'package:launchpad_app/screens/account/account_view.dart';
import 'package:launchpad_app/services/firebase_auth/authentication_service.dart';

/// A controller for the [AccountRoute] widget.
class AccountController extends State<AccountRoute> {
  /// Handles requests by the user to log out of the app, a process initialized by taps on the "Logout" button in this
  /// route.
  void onLogout() {
    AuthenticationService.signOut();
  }

  @override
  Widget build(BuildContext context) => AccountView(this);
}
