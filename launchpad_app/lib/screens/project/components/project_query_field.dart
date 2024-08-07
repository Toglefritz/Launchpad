import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:launchpad_app/components/loader/wave_loading_indicator.dart';
import 'package:launchpad_app/screens/project/project_controller.dart';

/// A widget providing a text input for the user to submit queries about a project.
///
/// While working on a project, the user may find areas for which they have questions or need additional clarification.
/// This widget provides a text input field for the user to submit queries about the project. The queries are then sent
/// to the AI model for processing and generating responses.
///
/// The text field has two states: one for when the AI model is processing the user's query and one for when the AI
/// model is ready to receive a new query. When the AI model is processing the user's query, the text field is disabled
/// and displays a loading indicator. When the AI model is ready to receive a new query, the text field is enabled and
/// displays a send button.
class ProjectQueryField extends StatelessWidget {
  /// Creates an instance of the [ProjectQueryField] widget.
  const ProjectQueryField({
    required this.state, super.key,
  });

  /// A controller for this widget.
  final ProjectController state;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: state.queryController,
      decoration: InputDecoration(
        hintText: state.isChatLoading
            ? AppLocalizations.of(context)!.loading
            : AppLocalizations.of(context)!.chatInputHint,
        suffixIcon: state.isChatLoading
            ? Transform.scale(
          scale: 0.5,
          child: const WaveLoadingIndicator(),
        )
            : GestureDetector(
          onTap: () => state.onQuery(state.queryController.text),
          child: const Icon(Icons.send),
        ),
      ),
      minLines: 1,
      maxLines: 4,
      enabled: !state.isChatLoading,
      onFieldSubmitted: state.onQuery,
    );
  }
}
