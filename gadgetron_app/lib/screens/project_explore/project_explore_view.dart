import 'package:firebase_vertexai/firebase_vertexai.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:gadgetron_app/components/app_bar_button.dart';
import 'package:gadgetron_app/screens/project_explore/components/chat_message.dart';
import 'package:gadgetron_app/screens/project_explore/project_explore_controller.dart';
import 'package:gadgetron_app/screens/project_search/project_search_controller.dart';
import 'package:gadgetron_app/services/firebase_gemini/models/message_role.dart';
import 'package:gadgetron_app/theme/insets.dart';

/// A view for the [ProjectSearchController] widget.
///
/// This view is displayed after the app has obtained a response from Gemini for the user's project description
/// submission.
class ProjectExploreView extends StatelessWidget {
  /// A controller for this view.
  final ProjectExploreController state;

  /// Creates an instance of the [ProjectExploreView] widget.
  const ProjectExploreView(
    this.state, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: AppBarButton(
          icon: const Icon(Icons.arrow_back),
          onTap: () => Navigator.pop(context),
        ),
        title: Text(
          AppLocalizations.of(context)!.projectExploreTitle,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        actions: [
          AppBarButton(
            icon: const Icon(Icons.feedback_outlined),
            onTap: () => {
              // TODO(Toglefritz): implement feedback
            },
          ),
        ],
      ),
      body: SafeArea(
        child: CustomScrollView(
          controller: state.scrollController,
          slivers: <Widget>[
            SliverPadding(
              padding: const EdgeInsets.all(Insets.small),
              sliver: SliverToBoxAdapter(
                child: SelectionArea(
                  child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: state.chat!.history.length,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      final Content chatMessage = state.chat!.history.toList()[index];
                      final String messageContents = state.getContentText(chatMessage);

                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: Insets.small),
                        child: ChatMessage(
                          messageContents: messageContents,
                          role: MessageRole.values.firstWhere((role) => role.identifier == chatMessage.role),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
            SliverFillRemaining(
              hasScrollBody: false,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(Insets.medium),
                    child: TextField(
                      controller: state.exploreFieldController,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
