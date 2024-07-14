/// Represents the thumbnail of a search result. This thumbnail is, in turn, represented by a JSON object within the
/// "pagemap" field of the search result JSON returned by the Google Custom Search API.
class CseThumbnail {
  /// The URL of the thumbnail image.
  final String src;

  /// The width of the thumbnail image.
  final String width;

  /// The height of the thumbnail image.
  final String height;

  /// Creates an instance of [CseThumbnail] with the specified URL, width, and height.
  CseThumbnail({
    required this.src,
    required this.width,
    required this.height,
  });

  /// Returns a [CseThumbnail] instance from the JSON content returned by the Google Custom Search API.
  factory CseThumbnail.fromJson(Map<String, dynamic> json) {
    return CseThumbnail(
      src: json['src'] as String,
      width: json['width'] as String,
      height: json['height'] as String,
    );
  }
}
