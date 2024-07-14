import 'package:firebase_vertexai/firebase_vertexai.dart';
import 'package:flutter/material.dart';
import 'package:launchpad_app/screens/project_explore/project_explore_loading_view.dart';
import 'package:launchpad_app/screens/project_explore/project_explore_route.dart';
import 'package:launchpad_app/screens/project_explore/project_explore_view.dart';
import 'package:launchpad_app/screens/project_search/project_search_route.dart';
import 'package:launchpad_app/services/firebase_gemini/gemini_service.dart';
import 'package:launchpad_app/services/search/models/search.dart';
import 'package:launchpad_app/services/search/models/search_extensions.dart';
import 'package:launchpad_app/services/search/models/search_result.dart';
import 'package:launchpad_app/services/search/search_service.dart';
import 'package:url_launcher/url_launcher.dart';

/// A controller for the [ProjectSearchRoute] widget.
class ProjectExploreController extends State<ProjectExploreRoute> {
  /// A [ChatSession] representing a multi-turn conversation between the user and the Gemini model. This session
  /// contains, among other information, this history of the conversation. This [ChatSession] history is presented to
  /// the user in this route.
  ChatSession? chat;

  /// A list of messages in the conversation. Each message is created either by the user or by the Gemini model. In the
  /// case of messages from Gemini, if they originate from responses that include function calls, the function calls are
  /// performed and their results are displayed in the conversation.
  List<Content> messages = [];

  /// A controller for the [CustomScrollView] widget used in this view. This controller is used to scroll the view to
  /// the bottom when new messages are added to the chat history.
  final ScrollController scrollController = ScrollController();

  /// A controller for the [TextField] used to submit additional queries to the Gemini model.
  final TextEditingController exploreFieldController = TextEditingController();

  /// Determines if the app is currently awaiting a response from the Gemini model for a new query.
  bool isWaitingForResponse = false;

  @override
  void initState() {
    super.initState();
    // Start a chat session with the Gemini system.
    _startChatSession();

    // Add the initial user message to the conversation.
    messages.add(
      Content(
        'user',
        [
          TextPart(widget.projectDescription),
        ],
      ),
    );
  }

  /// Starts a [ChatSession] with the Gemini model. This session is used to enable a multi-turn conversation with the
  /// Gemini model about the project idea provided to this route.
  Future<void> _startChatSession() async {
    try {
      // Start a chat session with the Gemini model.
      final ChatSession chatSession = await GeminiService.startChat();
      chat = chatSession;
    } catch (e) {
      debugPrint('Starting chat with Gemini failed with exception, $e');
      // TODO(Toglefritz): How should this error be handled?

      rethrow;
    }

    // After the chat session is started, submit the project description to the Gemini model.
    await _submitProjectDescription();
  }

  /// Submits the user's project description to the Gemini model to obtain a response.
  Future<void> _submitProjectDescription() async {
    // Obtain the project description provided by the user in the [ProjectSearchRoute].
    final String projectDescription = widget.projectDescription;

    // Create a Content object from the project description to send to the Gemini model.
    final Content projectDescriptionContent = Content.text(projectDescription);

    // Submit the project description to the Gemini model to obtain a response.
    final GenerateContentResponse response = await GeminiService.sendChatMessage(
      chat: chat!,
      content: projectDescriptionContent,
    );

    debugPrint('Received response from Gemini: ${response.text}');

    // Parse the response before adding it to the chat history.
    await _parseResponse(response);

    // Scroll to the bottom of the conversation so the most recent message is visible.
    _scrollToBottom();
  }

  /// Parses the response from the Gemini model and adds the response to the chat history.
  ///
  /// Responses from the Gemini model may contain function calls. This method processes the response to execute any
  /// function calls and adds the results to the chat history.
  Future<void> _parseResponse(GenerateContentResponse response) async {
    // Get the first candidate from the response. The app always uses the first candidate.
    final Content candidate = response.candidates.first.content;

    // Get a list of function call parts from the candidate.
    final List<FunctionCall> functionCalls = candidate.parts.whereType<FunctionCall>().toList();

    // If the candidate contains function calls, execute the function calls and send the responses back to the
    // Gemini model.
    final List<FunctionResponse> functionCallResults;
    if (functionCalls.isNotEmpty) {
      functionCallResults = await _executeFunctionCalls(functionCalls);
    }
    // Otherwise, if no function calls are present, add the candidate to the chat history.
    else {
      setState(() {
        messages.add(candidate);
      });

      // Since the response is only text, parsing is complete.
      return;
    }

    // Create a Content object from the function call results.
    final Content functionCallResultsContent = Content.functionResponses(functionCallResults);

    // Submit the function call results to the Gemini model.
    await _submitFunctionCallResults(functionCallResultsContent);
  }

  /// Handles submission of a query from the user to explore the results returned by the Gemini model.
  ///
  /// This query may request a variety of information, such as more details on a specific project, questions about a
  /// part of the results, a request for more results, or other requests.
  Future<void> onExplorationQuery() async {
    // Cache the current text field value before it is cleared.
    final String query = exploreFieldController.text;

    // Clear the text field now that the query is about to be submitted to the Gemini model.
    exploreFieldController.clear();

    // Put the input field into a loading state to indicate that the app is waiting for a response from the model.
    setState(() {
      isWaitingForResponse = true;
    });

    // Create a Content object from the query.
    final Content queryContent = Content.text(query);

    // Submit the new query to the Gemini model.
    await GeminiService.sendChatMessage(chat: chat!, content: queryContent);

    // Scroll to the bottom of the chat history so the most recent message is visible. Also put the input field back
    // into a non-loading state.
    if (scrollController.hasClients) {
      setState(() {
        isWaitingForResponse = false;

        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      });
    } else {
      setState(() {
        isWaitingForResponse = false;
      });
    }
  }

  /// Processes all function calls in the response from the Gemini model. This function returns a list of responses
  /// that include the results of the function calls.
  ///
  /// A Gemini model can include function calls in its responses. This method processes the function calls and sends
  /// the results back to the Gemini model. This enables the Gemini model to incorporate the results of the function
  /// calls into its responses. However, to guard against the Gemini model returning function calls in its responses
  /// that cannot be executed due to issues like the function not existing, the arguments being incorrect, or other
  /// issues, this method verifies the validity of each function call before executing it.
  Future<List<FunctionResponse>> _executeFunctionCalls(List<FunctionCall> functionCalls) async {
    // A list of Content objects representing the responses to the function calls.
    final List<FunctionResponse> functionResponses = [];

    // Process each function call in the list.
    for (final FunctionCall functionCall in functionCalls) {
      // Check if the function call is valid for use in the SearchService class.
      if (_isValidSearchFunctionCall(functionCall)) {
        // If the function call is valid, execute the function call and add the result to the chat history.
        final FunctionResponse response = await _executeSearchFunctionCall(functionCall);

        // Add the response to the list of function responses.
        functionResponses.add(response);
      }
    }

    // Return the function call results.
    return functionResponses;
  }

  /// Executes an individual function call from the Gemini model.
  ///
  /// When a function call is valid for use in the [SearchService] class, this method executes the function call uses
  /// the result to create a [Content] object. This [Content] object will be included in a list of responses for all
  /// function calls in the response from the Gemini model. This list will then be sent back to the Gemini model so
  /// the information can be incorporated into the conversation.
  Future<FunctionResponse> _executeSearchFunctionCall(FunctionCall functionCall) async {
    // Get the query string from the arguments. A null check is used here because the app previously verified that
    // the 'query' argument is present and is a string.
    final String query = functionCall.args['query']! as String;

    // Perform a search using the query string via a Google Programmable Search Engine.
    final Search search = await SearchService.performSearch(query);

    // The app assumes that the first result will be the most relevant result.
    final SearchResult firstResult = search.firstResult;

    // Create a FunctionResponse object to send back to the Gemini model.
    final FunctionResponse functionResponse = FunctionResponse(
      functionCall.name,
      {
        'title': firstResult.title,
        'link': firstResult.link.toString(),
      },
    );

    // Return the Content object.
    return functionResponse;
  }

  /// Returns a boolean that determines if the function call and its arguments are valid for use in the [SearchService]
  /// class. To perform this check, the following steps are taken:
  ///
  ///   1. Check if the function name is 'performSearch'.
  ///   2. Check if the arguments contain a 'query' key. Any other arguments are ignored.
  ///   3. Check if the 'query' argument is a string.
  bool _isValidSearchFunctionCall(FunctionCall functionCall) {
    // Check if the function name is 'performSearch'.
    if (functionCall.name == 'performSearch') {
      // Check if the arguments contain a 'query' key. The app will ignore any other arguments that may erroneously
      // be included in the function call.
      if (functionCall.args.containsKey('query')) {
        // Check if the 'query' argument is a string.
        if (functionCall.args['query'] is String) {
          return true;
        }
      }
    }

    return false;
  }

  /// Submits the results from a list of function calls back to the Gemini model.
  Future<void> _submitFunctionCallResults(Content functionCallResults) async {
    // Submit the function call results to the Gemini model.
    final GenerateContentResponse response = await GeminiService.sendChatMessage(
      chat: chat!,
      content: functionCallResults,
    );

    debugPrint('Received response from Gemini function call result submission: ${response.text}');

    // Parse the response before adding it to the chat history.
    await _parseResponse(response);

    _scrollToBottom();
  }

  /// Returns the text content of a [Content] object to display in the chat history.
  String getContentText(Content chatMessage) {
    // Get the parts of the chat message.
    final List<Part> parts = chatMessage.parts;

    // Get the first part of the chat message that has the type, TextPart.
    final TextPart textPart = parts.firstWhere(
      (Part part) => part is TextPart,
      orElse: () => parts.first,
    ) as TextPart;

    return textPart.text;
  }

  /// Scrolls to the bottom of the chat history. The app does this when a new message is added to the chat history
  /// so that the most recent message is visible to the user.
  void _scrollToBottom() {
    // If the scroll controller has clients, which will be the case if the ProjectExploreView is being displayed,
    // scroll to the bottom of the chat history so the most recent message is visible.
    if (scrollController.hasClients) {
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  /// Handles taps on links within the message content. Typically, these links will be returned within the responses
  /// from the Gemini model.
  Future<void> onLinkTap(String text, String? href, String title) async {
    try {
      // If the link is a URL, attempt to open the URL in the device's default browser.
      if (href != null) {
        await launchUrl(Uri.parse(href));
      }
    } catch (e) {
      debugPrint('Failed to open URL with exception, $e');

      // TODO(Toglefritz): How should this error be handled?
    }
  }

  @override
  Widget build(BuildContext context) {
    // If a response has not been received from the Gemini model, display a loading view.
    if (chat?.history.isEmpty ?? true) {
      return ProjectExploreLoadingView(this);
    }
    // Once a response is received, display the results.
    else {
      return ProjectExploreView(this);
    }
  }
}
