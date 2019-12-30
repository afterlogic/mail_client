import 'package:aurora_mail/utils/internationalization.dart';
import 'package:flutter/material.dart';

enum DiscardComposeChangesOption { discard, save }

class DiscardComposeChangesDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(i18n(context, "compose_discard_save_dialog_title")),
      content: Text(i18n(context, "compose_discard_save_dialog_description")),
      actions: <Widget>[
        FlatButton(
          child: Text(i18n(context, "btn_cancel").toUpperCase()),
          onPressed: () {
            Navigator.pop(context);
            return DiscardComposeChangesOption.save;
          },
        ),
        FlatButton(
          child: Text(i18n(context, "btn_discard").toUpperCase()),
          onPressed: () {
            Navigator.pop(context);
            return DiscardComposeChangesOption.discard;
          },
        ),
        FlatButton(
          child: Text(i18n(context, "btn_save").toUpperCase()),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
