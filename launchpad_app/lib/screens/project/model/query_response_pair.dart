/// Represents a question/query from the user and the response from the AI model.
///
/// This class is used to store a pair of a query from the user and the response from the AI model. This pair is used to
/// display the query and response history to the user in an FAQ-style format. The user's queries are used as the titles
/// of expansion tiles, and the AI model's responses are displayed as the content of the expansion tiles.
class QueryResponsePair {
  /// The query from the user.
  final String query;

  /// The response from the AI model.
  final String response;

  /// Creates a new [QueryResponsePair] with the given [query] and [response].
  const QueryResponsePair({
    required this.query,
    required this.response,
  });
}
