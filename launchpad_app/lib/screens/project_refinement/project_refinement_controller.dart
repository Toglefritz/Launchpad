import 'dart:convert';

import 'package:firebase_vertexai/firebase_vertexai.dart';
import 'package:flutter/material.dart';
import 'package:launchpad_app/screens/project/project_route.dart';
import 'package:launchpad_app/screens/project_refinement/project_refinement_loading_view.dart';
import 'package:launchpad_app/screens/project_refinement/project_refinement_route.dart';
import 'package:launchpad_app/screens/project_refinement/project_refinement_view.dart';
import 'package:launchpad_app/services/firebase_gemini/gemini_service.dart';
import 'package:launchpad_app/services/project/project.dart';
import 'package:launchpad_app/services/search/models/search.dart';
import 'package:launchpad_app/services/search/models/search_extensions.dart';
import 'package:launchpad_app/services/search/models/search_result.dart';
import 'package:launchpad_app/services/search/search_service.dart';
import 'package:url_launcher/url_launcher.dart';

/// A controller for the [ProjectRefinementRoute] widget.
class ProjectRefinementController extends State<ProjectRefinementRoute> {
  /// A [ChatSession] representing a multi-turn conversation between the user and the Gemini model. Note, however, that
  /// the user interface does not resemble a traditional chat interface. Rather, the interface displays the current
  /// project draft created from the initial project description provided by the user or from the user's subsequent
  /// feedback. So, the "chat" effectively only displays the most recent message from the Gemini model.
  ChatSession? chat;

  /// A [Project] object representing the project draft created from the initial project description provided by the
  /// user or from the user's subsequent feedback. This object will be modified when the user provides feedback to the
  /// Gemini model.
  Project? project;

  /// A controller for the [TextField] used to submit additional queries to the Gemini model.
  final TextEditingController refineFieldController = TextEditingController();

  /// Determines if the app is currently awaiting a response from the Gemini model for a new query.
  bool isWaitingForResponse = true;

  /// Determines if a response to the initial project description has been received from the Gemini model.
  bool get hasResponse => project != null;

  /// The steps within the [project] are displayed in a [Stepper] widget. This value determines which steps is
  /// currently "active" and displayed to the user in this widget.
  int currentStep = 0;

  @override
  void initState() {
    super.initState();
    // Start a "chat" session with the Gemini system.
    _startChatSession();
  }

  /// Starts a [ChatSession] with the Gemini model. This session is used to enable a multi-turn conversation with the
  /// Gemini model about the project idea provided to this route. This route only displays the parsed project idea
  /// from the most recent message from Gemini and does not display a traditional chat interface.
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

  /// Submits the user's project description to the Gemini model to obtain a response. This response forms the initial
  /// draft of the project that the user can then refine.
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
  }

  /// Parses the response from the Gemini model to create a [Project] object that represents the project draft.
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

      // Create a Content object from the function call results.
      final Content functionCallResultsContent = Content.functionResponses(functionCallResults);

      // Submit the function call results to the Gemini model.
      await _submitFunctionCallResults(functionCallResultsContent);
    }

    // Get the first TextPart from the first Candidate from the response. The app assumes that this part will contain
    // the project draft.
    final String responseText = getContentText(candidate);

    // The Gemini model may include additional information before the JSON object or may include a Markdown code block
    // around the JSON object. This extra content or code block is removed before the JSON object is parsed.
    final int jsonStartIndex = responseText.indexOf('{');
    final int jsonEndIndex = responseText.lastIndexOf('}');
    final String projectDraft = responseText.substring(jsonStartIndex, jsonEndIndex + 1);

    // Try to parse the project draft as a JSON object.
    final Map<String, dynamic> projectDraftJson;
    try {
      projectDraftJson = jsonDecode(projectDraft) as Map<String, dynamic>;
    } catch (e) {
      debugPrint('Failed to parse project draft as JSON with exception, $e');

      // TODO(Toglefritz): How should this error be handled? Perhaps make another request to Gemini?

      return;
    }

    // Create a Project object from the candidate.
    setState(() {
      project = Project.fromJson(projectDraftJson);
      isWaitingForResponse = false;
    });
  }

  /// Handles taps on steps within the [Stepper] widget that displays the project steps. Tapping on a step will
  /// "open" that step in the [Stepper].
  void onStepTapped(int step) {
    setState(() {
      currentStep = step;
    });
  }

  /// Handles submission of a query from the user to explore the results returned by the Gemini model.
  ///
  /// This query may request a variety of information, such as more details on a specific project, questions about a
  /// part of the results, a request for more results, or other requests.
  Future<void> onRefinementQuery() async {
    // Cache the current text field value before it is cleared.
    final String query = refineFieldController.text;

    // Clear the text field now that the query is about to be submitted to the Gemini model.
    refineFieldController.clear();

    // Put the input field into a loading state to indicate that the app is waiting for a response from the model.
    setState(() {
      isWaitingForResponse = true;
    });

    // Create a Content object from the query.
    // TODO(Toglefritz): Considering adding additional content to augment the project feedback from the user.
    final Content queryContent = Content.text(query);

    // Submit the new query to the Gemini model.
    final GenerateContentResponse response = await GeminiService.sendChatMessage(chat: chat!, content: queryContent);

    debugPrint('Received response from Gemini: ${response.text}');

    // Parse the response.
    await _parseResponse(response);
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

  /// Handles taps on the button used to finalize the project draft and navigate to the [ProjectRoute]
  Future<void> onProjectAccepted() async {
    // Navigate to the project execution view.
    await Navigator.pushReplacement(
      context,
      MaterialPageRoute<void>(
        builder: (context) => ProjectRoute(
          project: project!,
          isNewProject: true,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // If a response has not been received from the Gemini model, display a loading view.
    if (project == null || isWaitingForResponse) {
      return ProjectRefinementLoadingView(this);
    }
    // Once a response is received, display the results.
    else {
      return ProjectRefinementView(this);
    }
  }
}
