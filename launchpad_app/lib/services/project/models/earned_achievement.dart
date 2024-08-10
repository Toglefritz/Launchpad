import 'package:launchpad_app/extensions/json_typedef.dart';
import 'package:launchpad_app/services/project/models/achievement.dart';

/// Represents an achievement that has been earned by a user.
///
/// An [EarnedAchievement] object represents an achievement that has been earned by a user. This class extends
/// [Achievement]. [EarnedAchievement]s differ from [Achievement]s in that they do not have a description and, by
/// definition, are complete.
class EarnedAchievement extends Achievement {
  /// The timestamp at which the achievement was earned.
  final DateTime date;

  /// Creates an [EarnedAchievement] object.
  EarnedAchievement({
    required super.id,
    required super.title,
    required this.date,
  }) : super(
          description: '',
          isComplete: true,
        );

  /// Creates an [EarnedAchievement] object from a JSON object.
  factory EarnedAchievement.fromJson(JSONObject json) {
    return EarnedAchievement(
      id: json['id'] as String,
      title: json['name'] as String,
      date: _convertTimestampToDateTime(json['date'] as JSONObject),
    );
  }

  /// Converts a Firestore timestamp into a `DateTime` object.
  ///
  /// Firestore timestamps are typically represented as a map with two keys:
  /// `_seconds` and `_nanoseconds`. This function converts that format into a
  /// Dart `DateTime` object.
  ///
  /// The Firestore timestamp map might look like this:
  ///
  /// ```dart
  /// {
  ///   "_seconds": 1723290651,
  ///   "_nanoseconds": 540000000
  /// }
  /// ```
  ///
  /// This timestamp represents the exact point in time stored in the Firestore
  /// database. The `_seconds` value is the number of seconds since the Unix epoch,
  /// and `_nanoseconds` adds additional precision.
  ///
  /// The function works by converting the `_seconds` value into a `DateTime` object
  /// and then adding the `_nanoseconds` as microseconds (since `DateTime` supports
  /// microsecond precision).
  static DateTime _convertTimestampToDateTime(Map<String, dynamic> timestamp) {
    final int seconds = timestamp['_seconds'] as int;
    final int nanoseconds = timestamp['_nanoseconds'] as int;

    // Convert seconds to DateTime
    final DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(seconds * 1000);

    // Add nanoseconds as microseconds (1 microsecond = 1000 nanoseconds)
    return dateTime.add(Duration(microseconds: nanoseconds ~/ 1000));
  }

  /// A convenience getter to return the timestamp in the format, `MM/dd/yyyy`.
  String get formattedDate => '${date.month}/${date.day}/${date.year}';
}
