import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:launchpad_app/components/app_bar/app_bar_button.dart';
import 'package:launchpad_app/components/buttons/tertiary_cta_button.dart';
import 'package:launchpad_app/screens/account/account_controller.dart';
import 'package:launchpad_app/screens/account/account_route.dart';
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
        leading: AppBarButton(
          icon: const Icon(Icons.arrow_back),
          onTap: () => Navigator.pop(context),
        ),
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
            // TODO(Toglefritz): Implement the remainder of this route

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
