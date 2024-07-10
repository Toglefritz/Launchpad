import 'package:gadgetron_app/services/search/models/page_map.dart';

/// Represents a result returned from a CSE search.
///
/// See https://developers.google.com/custom-search/v1/reference/rest/v1/Search#Result for more information about the
/// contents of the CSE responses.
class SearchResult {
  /// The title of the search result, in plain text.
  final String title;

  /// The full URL to which the search result is pointing.
  final Uri link;

  /// An abridged version of this search result’s URL.
  final String displayLink;

  /// The snippet of the search result, in plain text.
  final String snippet;

  /// The URL displayed after the snippet for each search result.
  final String formattedUrl;

  /// Contains [PageMap] information for this search result.
  final PageMap pageMap;

  /// Creates a [SearchResult] object with the specified title, link, display link, snippet, formatted URL, and page
  /// map.
  SearchResult({
    required this.title,
    required this.link,
    required this.displayLink,
    required this.snippet,
    required this.formattedUrl,
    required this.pageMap,
  });

  /// Returns a [SearchResult] instance from JSON content returned from a CSE search.
  factory SearchResult.fromJson(Map<String, dynamic> json) {
    return SearchResult(
      title: json['title'] as String,
      link: Uri.parse(json['link'] as String),
      displayLink: json['displayLink'] as String,
      snippet: json['snippet'] as String,
      formattedUrl: json['formattedUrl'] as String,
      pageMap: PageMap.fromJson(json['pagemap'] as Map<String, dynamic>),
    );
  }
}
