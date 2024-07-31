import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:launchpad_app/components/buttons/secondary_cta_button.dart';
import 'package:launchpad_app/components/buttons/tertiary_cta_button.dart';
import 'package:launchpad_app/screens/account/account_controller.dart';
import 'package:launchpad_app/screens/account/account_route.dart';
import 'package:launchpad_app/services/firebase_auth/models/profile_picture.dart';
import 'package:launchpad_app/services/firebase_auth/user_profile_service.dart';
import 'package:launchpad_app/theme/insets.dart';

/// A view for the [AccountRoute] widget.
class AccountView extends StatelessWidget {
  /// A controller for this view.
  final AccountController state;

  /// Creates an instance of the [AccountView] widget.
  const AccountView(
    this.state, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text(
          AppLocalizations.of(context)!.accountLabel,
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
              child: Card(
                margin: const EdgeInsets.all(Insets.medium),
                child: SizedBox(
                  width: double.infinity,
                  child: Column(
                    children: <Widget>[
                      ValueListenableBuilder(
                        valueListenable: UserProfileService.profilePictureNotifier,
                        builder: (BuildContext context, ProfilePicture profilePicture, Widget? child) => Padding(
                          padding: const EdgeInsets.all(Insets.medium),
                          child: Image.asset(
                            'assets/profile_pictures/${profilePicture.fileName}',
                            width: 200,
                            height: 200,
                          ),
                        ),
                      ),
                      if (state.user.email != null)
                        Padding(
                          padding: const EdgeInsets.fromLTRB(
                            Insets.medium,
                            0.0,
                            Insets.medium,
                            Insets.medium,
                          ),
                          child: Text(
                            state.user.email!,
                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                  fontSize: 18,
                                ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),

            // A button used to change the user's profile picture.
            SliverPadding(
              padding: const EdgeInsets.all(Insets.medium),
              sliver: SliverToBoxAdapter(
                child: SecondaryCTAButton(
                  onPressed: state.onChangePicture,
                  icon: Icon(
                    Icons.edit,
                    color: Theme.of(context).primaryColorDark,
                  ),
                  label: Text(
                    AppLocalizations.of(context)!.changeProfilePicture.toUpperCase(),
                  ),
                ),
              ),
            ),

            // User profile and account related controls
            SliverPadding(
              padding: const EdgeInsets.all(Insets.medium),
              sliver: SliverToBoxAdapter(
                child: TertiaryCTAButton(
                  onPressed: state.onLogout,
                  icon: Icon(
                    Icons.logout,
                    color: Theme.of(context).primaryColorDark,
                  ),
                  label: Text(AppLocalizations.of(context)!.logout.toUpperCase()),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
