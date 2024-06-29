/// Represents methods that can be used to sign up (create an account) or log into the app.
///
/// Firebase Auth offers several methods for authenticating users. The [AuthMethod] enum represents the methods that
/// can be used to sign up (create an account) or log into this app. For clarity, methods that are not currently
/// supported by the app are commented out.
enum AuthMethod {
  /// Authentication using a username and password.
  basicAuth,

  /// Authentication using a phone number.
  //phone,

  /// Authentication without providing any credentials.
  //anonymous,

  /// Authentication through a Google account.
  google,

  /// Authentication through a Microsoft account.
  //microsoft,

  /// Authentication through a Facebook (Meta?) account.
  //facebook,

  /// Authentication through an Apple account.
  apple,

  /// Authentication through a GitHub account.
  gitHub;
}
