import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:launchpad_app/components/app_bar/app_bar_button.dart';
import 'package:launchpad_app/screens/account/account_route.dart';
import 'package:launchpad_app/screens/profile_picture/profile_picture_controller.dart';
import 'package:launchpad_app/services/firebase_auth/models/profile_picture.dart';
import 'package:launchpad_app/theme/insets.dart';

/// A view for the [AccountRoute] widget.
class ProfilePictureView extends StatelessWidget {
  /// A controller for this view.
  final ProfilePictureController state;

  /// Creates an instance of the [ProfilePictureView] widget.
  const ProfilePictureView(
    this.state, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        leading: AppBarButton(
          icon: const Icon(Icons.arrow_back),
          onTap: () => Navigator.pop(context),
        ),
        title: Text(
          AppLocalizations.of(context)!.profilePicture,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontSize: 24,
              ),
        ),
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: <Widget>[
            // A Card displaying the user's avatar image and email address.
            SliverToBoxAdapter(
              child: Text(
                AppLocalizations.of(context)!.selectAnImage,
                style: Theme.of(context).textTheme.displayMedium,
                textAlign: TextAlign.center,
              ),
            ),
            SliverGrid.count(
              crossAxisCount: 3,
              children: List.generate(
                ProfilePicture.values.length,
                (index) {
                  final profilePicture = ProfilePicture.values[index];
                  return Padding(
                    padding: const EdgeInsets.all(Insets.medium),
                    child: GestureDetector(
                      onTap: () => state.onImageSelected(profilePicture),
                      child: Image.asset(
                        'assets/profile_pictures/${profilePicture.fileName}',
                        width: MediaQuery.of(context).size.width / 3,
                        height: MediaQuery.of(context).size.width / 3,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
