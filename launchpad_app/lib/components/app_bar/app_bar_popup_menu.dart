import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:launchpad_app/services/firebase_auth/authentication_service.dart';
import 'package:launchpad_app/theme/insets.dart';

/// A menu button displayed in the [AppBar].
///
/// This button consists of an icon that, when tapped, displays a popup menu with a list of options. The icon is
/// displayed inside a subtle circular border.
class AppBarPopupMenu extends StatelessWidget {
  /// Creates an instance of the [AppBarPopupMenu] widget.
  const AppBarPopupMenu({
    super.key,
  });

  /// Handles the user's request to log out of the app.
  Future<void> _onLogout() async {
    await AuthenticationService.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(Insets.small),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: Theme.of(context).dividerColor,
        ),
      ),
      child: PopupMenuButton<String>(
        onSelected: (_) => _onLogout,
        itemBuilder: (BuildContext context) {
          return [
            PopupMenuItem<String>(
              value: AppLocalizations.of(context)!.logout,
              child: Text(
                AppLocalizations.of(context)!.logout,
                textAlign: TextAlign.center,
              ),
            ),
          ];
        },
        icon: Icon(
          Icons.more_vert,
          color: Theme.of(context).primaryColorDark,
        ),
      ),
    );
  }
}
