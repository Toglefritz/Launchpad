import 'package:flutter/material.dart';
import 'package:launchpad_app/screens/account/account_controller.dart';

/// A route displaying information about the user' Launchpad account and allowing access to account related settings.
///
/// Basically every part of the Launchpad app requires users to be authenticated. This is because, from a user's
/// perspective, the app creates data related to the user and their projects. Authentication ensures that the data is
/// secure and that the user is the only one who can access it. From a business perspective, many of the cloud services
/// used by the Launchpad app incur costs. By requiring users to authenticate, the app can ensure that only users who
/// have agreed to the terms of service and privacy policy are able to use the app and incur costs. This also allows
/// for the implementation of checks against abuse of the app's services.
///
/// This route displays information about the user's Launchpad account and allows access to account related settings.
class AccountRoute extends StatefulWidget {
  /// Creates an instance of the [AccountRoute] widget.
  const AccountRoute({super.key});

  @override
  State<AccountRoute> createState() => AccountController();
}
