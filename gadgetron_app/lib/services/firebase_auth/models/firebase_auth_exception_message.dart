import 'package:firebase_auth/firebase_auth.dart';

/// An enumeration of messages that can be include in [FirebaseAuthException]s when they are thrown during
/// authentication processes. This enumeration does not necessarily include every message that can be included in
/// these exceptions, but it does include the ones that have specific handling in the application.
enum FirebaseAuthExceptionMessage {
  /// Indicates that the password does not pass all of the requirements for a strong password, as enforced by
  /// Firebase Auth.
  weakPassword('weak-password'),

  /// Indicates that the email address provided is already in use by another account.
  emailAlreadyInUse('email-already-in-use'),

  /// Indicates that a user account with the provided email address was not found after an attempt to log in.
  userNotFound('user-not-found'),

  /// Indicates that the password provided during a login attempt was incorrect.
  wrongPassword('wrong-password');

  /// The message sent by the Firebase Auth plugin for each exception type.
  final String message;

  const FirebaseAuthExceptionMessage(this.message);
}
