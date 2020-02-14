import 'package:aurora_mail/modules/settings/models/language.dart';
import 'package:aurora_mail/utils/internationalization.dart';
import 'package:aurora_mail/utils/show_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LanguageSelectionDialog extends StatelessWidget {
  final Language selectedItem;
  final Function(Language) onItemSelected;

  const LanguageSelectionDialog(this.onItemSelected, this.selectedItem);

  static void show(BuildContext context, Language selected,
      Function(Language) onItemSelected) {
      dialog(
          context: context,
          builder: (_) => LanguageSelectionDialog(onItemSelected, selected));
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      titlePadding: EdgeInsets.all(24.0),
      title: Text(i18n(context, "settings_language")),
      content: SizedBox(
        height: 56.0 * Language.availableLanguages.length,
        width: 350.0,
        child: ListView(
            children: Language.availableLanguages
                .map((lang) => RadioListTile(
                      title: Text(lang == null
                          ? i18n(context, "settings_language_system")
                          : lang.name),
                      value: lang?.tag,
                      groupValue: selectedItem?.tag,
                      onChanged: (val) {
                        onItemSelected(lang);
                        Navigator.pop(context);
                      },
                    ))
                .toList()),
      ),
      actions: <Widget>[
        FlatButton(
          textColor: Theme.of(context).accentColor,
          child: Text(i18n(context, "btn_cancel")),
          onPressed: Navigator.of(context).pop,
        ),
      ],
    );
  }
}
