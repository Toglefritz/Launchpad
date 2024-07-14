/// Represents an image associated with a search result. This image is, in turn, represented by a JSON object within the
/// "pagemap" field of the search result JSON returned by the Google Custom Search API.
class CseImage {
  /// The URL of the image.
  final String? src;

  /// Creates an instance of [CseImage] with the specified URL.
  CseImage({
    required this.src,
  });

  /// Returns a [CseImage] instance from the JSON content returned by the Google Custom Search API.
  factory CseImage.fromJson(Map<String, dynamic> json) {
    return CseImage(
      src: json['src'] as String?,
    );
  }
}
