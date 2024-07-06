import 'package:firebase_vertexai/firebase_vertexai.dart';
import 'package:flutter/material.dart';
import 'package:gadgetron_app/screens/project_explore/project_explore_loading_view.dart';
import 'package:gadgetron_app/screens/project_explore/project_explore_route.dart';
import 'package:gadgetron_app/screens/project_explore/project_explore_view.dart';
import 'package:gadgetron_app/screens/project_search/project_search_route.dart';
import 'package:gadgetron_app/services/firebase_gemini/gemini_service.dart';
import 'package:url_launcher/url_launcher.dart';

/// A controller for the [ProjectSearchRoute] widget.
class ProjectExploreController extends State<ProjectExploreRoute> {
  /// A [ChatSession] representing a multi-turn conversation between the user and the Gemini model. This session
  /// contains, among other information, this history of the conversation. This [ChatSession] history is presented to
  /// the user in this route.
  ChatSession? chat;

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

    // Submit the project description to the Gemini model to obtain a response.
    final GenerateContentResponse response = await GeminiService.sendChatMessage(
      chat: chat!,
      prompt: projectDescription,
    );

    debugPrint('Received response from Gemini: ${response.text}');

    // If the scroll controller has clients, which will be the case if the ProjectExploreView is being displayed,
    // scroll to the bottom of the chat history so the most recent message is visible.
    if (scrollController.hasClients) {
      setState(() {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      });
    } else {
      setState(() {});
    }
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

    // Submit the new query to the Gemini model.
    await GeminiService.sendChatMessage(chat: chat!, prompt: query);

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
