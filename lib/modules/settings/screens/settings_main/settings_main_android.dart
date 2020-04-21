import 'package:aurora_mail/build_property.dart';
import 'package:aurora_mail/logger/logger.dart';
import 'package:aurora_mail/modules/auth/blocs/auth_bloc/auth_bloc.dart';
import 'package:aurora_mail/modules/auth/blocs/auth_bloc/auth_event.dart';
import 'package:aurora_mail/modules/settings/screens/about/about_route.dart';
import 'package:aurora_mail/modules/settings/screens/common_settings/common_settings_route.dart';
import 'package:aurora_mail/modules/settings/screens/manage_users/manage_users_route.dart';
import 'package:aurora_mail/modules/settings/screens/pgp_settings/pgp_settings_route.dart';
import 'package:aurora_mail/modules/settings/screens/sync_settings/sync_settings_route.dart';
import 'package:aurora_mail/shared_ui/confirmation_dialog.dart';
import 'package:aurora_mail/shared_ui/mail_bottom_app_bar.dart';
import 'package:aurora_mail/utils/base_state.dart';
import 'package:aurora_mail/utils/internationalization.dart';
import 'package:aurora_ui_kit/aurora_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsMainAndroid extends StatefulWidget {
  @override
  _SettingsMainAndroidState createState() => _SettingsMainAndroidState();
}

class _SettingsMainAndroidState extends BState<SettingsMainAndroid> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AMAppBar(
        title: Text(i18n(context, "settings")),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            leading: AMCircleIcon(Icons.tune),
            title: Text(i18n(context, "settings_common")),
            onTap: () => Navigator.pushNamed(context, CommonSettingsRoute.name),
          ),
          ListTile(
            leading: AMCircleIcon(Icons.sync),
            title: Text(i18n(context, "settings_sync")),
            onTap: () => Navigator.pushNamed(context, SyncSettingsRoute.name),
          ),
          if (BuildProperty.cryptoEnable)
            ListTile(
              leading: AMCircleIcon(Icons.vpn_key),
              title: Text(i18n(context, "pgp_settings")),
              onTap: () => Navigator.pushNamed(context, PgpSettingsRoute.name),
            ),
          if (BuildProperty.multiUserEnable)
            ListTile(
              leading: AMCircleIcon(Icons.account_circle),
              title: Text(i18n(context, "settings_accounts_manage")),
              onTap: () => Navigator.pushNamed(context, ManageUsersRoute.name),
            ),
          ListTile(
            leading: AMCircleIcon(Icons.info_outline),
            title: Text(i18n(context, "settings_about")),
            onLongPress: BuildProperty.logger
                ? () {
                    logger.enable = !logger.enable;
                  }
                : null,
            onTap: () => Navigator.pushNamed(context, AboutRoute.name),
          ),
          if (!BuildProperty.multiUserEnable)
            ListTile(
              leading: AMCircleIcon(Icons.exit_to_app),
              title: Text(i18n(context, "messages_list_app_bar_logout")),
              onTap: _exit,
            ),
        ],
      ),
      bottomNavigationBar:
          MailBottomAppBar(selectedRoute: MailBottomAppBarRoutes.settings),
    );
  }

  _exit() async {
    final result = await showDialog(
      context: context,
      builder: (_) => ConfirmationDialog(
        title: null,
        description: i18n(context, "confirm_exit"),
        actionText: i18n(context, "exit"),
      ),
    );
    if (result == true) {
      final authBloc = BlocProvider.of<AuthBloc>(context);
      authBloc.add(DeleteUser(authBloc.currentUser));
    }
  }
}
