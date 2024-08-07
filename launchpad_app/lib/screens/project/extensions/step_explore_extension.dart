import 'package:launchpad_app/screens/project/model/query_response_pair.dart';
import 'package:launchpad_app/services/project/models/how_to_step.dart';

/// An extension on the [HowToStep] class that adds a list of query/response pairs to the step. This list represents the
/// conversation between the user and the Gemini system. The conversation is used to create an interface in the style of
/// an FAQ in which each question/query is presented as the title of an `ExpansionTile` widget, with the response to the
/// query displayed when the user expands the tile.
extension StepExplore on HowToStep {
  /// A map that contains the conversation between the user and the Gemini system for each step.
  static final Map<HowToStep, List<QueryResponsePair>> _conversations = {};

  /// A list of query/response pairs that represent the conversation between the user and the Gemini system.
  List<QueryResponsePair> get conversation => _conversations[this] ??= [];

  set conversation(List<QueryResponsePair> value) => _conversations[this] = value;

  /// A getter for the list of query/response pairs that represent the conversation between the user and the Gemini.
  /// The order of the messages is reversed so that the most recent message is displayed first.
  List<QueryResponsePair> get reversedConversation => conversation.reversed.toList();
}
