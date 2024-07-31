/// An enumeration of the possible profile picture assets among which a user can choose.
enum ProfilePicture {
  /// The first profile picture asset.
  profilePicture1('profile_picture_1.png'),

  /// The second profile picture asset.
  profilePicture2('profile_picture_2.png'),

  /// The third profile picture asset.
  profilePicture3('profile_picture_3.png'),

  /// The fourth profile picture asset.
  profilePicture4('profile_picture_4.png'),

  /// The fifth profile picture asset.
  profilePicture5('profile_picture_5.png'),

  /// The sixth profile picture asset.
  profilePicture6('profile_picture_6.png'),

  /// The seventh profile picture asset.
  profilePicture7('profile_picture_7.png'),

  /// The eighth profile picture asset.
  profilePicture8('profile_picture_8.png'),

  /// The ninth profile picture asset.
  profilePicture9('profile_picture_9.png');

  /// The file name of the profile picture asset.
  final String fileName;

  const ProfilePicture(this.fileName);
}
