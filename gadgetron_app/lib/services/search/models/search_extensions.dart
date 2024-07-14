import 'package:gadgetron_app/services/search/models/search.dart';
import 'package:gadgetron_app/services/search/models/search_result.dart';

/// Extension methods for the [Search] class.
extension SearchExtensions on Search {
  /// Returns the first [SearchResult] in the [Search.results] list.
  SearchResult get firstResult => results.first;
}
