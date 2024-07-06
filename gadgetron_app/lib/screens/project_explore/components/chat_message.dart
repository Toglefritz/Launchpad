import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:gadgetron_app/services/firebase_gemini/models/message_role.dart';
import 'package:gadgetron_app/theme/insets.dart';

/// A widget that displays a chat message in the chat history.
///
/// The role of the message determines how a decorative element is displayed alongside the message content to provide
/// a visual indication of the message's role in the conversation.
class ChatMessage extends StatelessWidget {
  /// Creates an instance of the [ChatMessage] widget.
  const ChatMessage({
    required this.messageContents,
    required this.role,
    required this.onLinkTap,
    super.key,
  });

  /// The contents of the chat message.
  final String messageContents;

  /// The role of the message in the conversation.
  final MessageRole role;

  /// Handles taps on links within the message content.
  final void Function(String text, String? href, String title)? onLinkTap;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Align(
            alignment: Alignment.centerLeft,
            child: ClipRRect(
              borderRadius: const BorderRadius.all(
                Radius.circular(Insets.small),
              ),
              child: Container(
                color: role == MessageRole.model
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).primaryColorDark,
                width: role == MessageRole.model ? 4.0 : 2.0,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: Insets.medium),
          child: MarkdownBody(
            data: messageContents,
            styleSheet: MarkdownStyleSheet(
              p: role == MessageRole.model
                  ? Theme.of(context).textTheme.bodyMedium
                  : Theme.of(context).textTheme.bodySmall,
            ),
            onTapLink: onLinkTap,
          ),
        ),
      ],
    );
  }
}
