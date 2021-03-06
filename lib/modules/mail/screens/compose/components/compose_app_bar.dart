import 'package:aurora_mail/res/str/s.dart';
import 'package:aurora_mail/utils/base_state.dart';
import 'package:aurora_mail/utils/internationalization.dart';
import 'package:aurora_ui_kit/aurora_ui_kit.dart';
import 'package:flutter/material.dart';

enum ComposeAppBarAction {
  saveToDrafts,
  send,
  cancel,
}

class ComposeAppBar extends StatefulWidget implements PreferredSizeWidget {
  final Function(ComposeAppBarAction action) onAppBarActionSelected;

  const ComposeAppBar(this.onAppBarActionSelected);

  @override
  _ComposeAppBarState createState() => _ComposeAppBarState();

  @override
  final Size preferredSize = const Size.fromHeight(kToolbarHeight);
}

class _ComposeAppBarState extends BState<ComposeAppBar> {
  String selectedEmail;

  @override
  Widget build(BuildContext context) {
    return AMAppBar(
      centerTitle: false,
      leading: IconButton(
        icon: Icon(Icons.close),
        onPressed: () =>
            widget.onAppBarActionSelected(ComposeAppBarAction.cancel),
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.send),
          onPressed: () =>
              widget.onAppBarActionSelected(ComposeAppBarAction.send),
        ),
        PopupMenuButton<ComposeAppBarAction>(
          onSelected: widget.onAppBarActionSelected,
          itemBuilder: (BuildContext context) => [
            PopupMenuItem(
              value: ComposeAppBarAction.saveToDrafts,
              child: ListTile(
                leading: Icon(Icons.drafts),
                title: Text(i18n(context, S.btn_save)),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
