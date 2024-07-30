import 'dart:math';

/// A utility class for generating random UUIDs.
class UuidGenerator {
  /// Generates a random UUID (Universally Unique Identifier).
  ///
  /// This method generates a random UUID by creating random values for each component of the UUID. The resulting UUID
  /// is in the standard 8-4-4-4-12 format, consisting of 32 hexadecimal characters and 4 hyphens.
  ///
  /// Returns a [String] representing the generated UUID.
  static String generateUuid() {
    final Random random = Random();
    final StringBuffer uuid = StringBuffer();

    for (int i = 0; i < 8; i++) {
      uuid.write(_randomHexChar(random));
    }
    uuid.write('-');
    for (int i = 0; i < 4; i++) {
      uuid.write(_randomHexChar(random));
    }
    uuid.write('-');
    for (int i = 0; i < 4; i++) {
      uuid.write(_randomHexChar(random));
    }
    uuid.write('-');
    for (int i = 0; i < 4; i++) {
      uuid.write(_randomHexChar(random));
    }
    uuid.write('-');
    for (int i = 0; i < 12; i++) {
      uuid.write(_randomHexChar(random));
    }

    return uuid.toString();
  }

  /// Returns a random hexadecimal character as a [String].
  ///
  /// This helper method generates a random number between 0 and 15 (inclusive)
  /// and converts it to a hexadecimal character.
  ///
  /// Returns a [String] representing the hexadecimal character.
  static String _randomHexChar(Random random) {
    const String hexChars = '0123456789abcdef';
    return hexChars[random.nextInt(16)];
  }
}
