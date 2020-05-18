import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/models/folder.dart';
import 'package:aurora_mail/modules/mail/blocs/mail_bloc/mail_bloc.dart';
import 'package:aurora_mail/modules/mail/blocs/mail_bloc/mail_state.dart';
import 'package:aurora_mail/modules/mail/blocs/messages_list_bloc/messages_list_bloc.dart';
import 'package:aurora_mail/modules/mail/blocs/messages_list_bloc/messages_list_event.dart';
import 'package:aurora_mail/modules/mail/screens/messages_list/components/mail_folder.dart';
import 'package:aurora_mail/shared_ui/sized_dialog_content.dart';
import 'package:aurora_mail/utils/internationalization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MoveMessageDialog extends StatefulWidget {
  final List<Message> messages;
  final MessagesListBloc bloc;
  MoveMessageDialog(this.messages, this.bloc);
  @override
  _MoveMessageDialogState createState() => _MoveMessageDialogState();
}

class _MoveMessageDialogState extends State<MoveMessageDialog> {
  List<Folder> stack = [];

  Folder get current {
    if (stack.isEmpty) {
      return null;
    } else {
      return stack.last;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (current == null) {
          return true;
        } else {
          stack.removeLast();
          setState(() {});
          return false;
        }
      },
      child: AlertDialog(
        title: Text(i18n(context, "label_message_move_to") +
            (current == null ? "" : FolderHelper.getTitle(context, current))),
        content: SizedDialogContent(
          child: BlocBuilder<MailBloc, MailState>(
              bloc: BlocProvider.of<MailBloc>(context),
              condition: (prevState, state) =>
                  state is FoldersLoaded || state is FoldersEmpty,
              builder: (ctx, state) {
                if (state is FoldersLoaded) {
                  return _buildFolders(state);
                } else {
                  return SizedBox.shrink();
                }
              }),
        ),
        actions: <Widget>[
          FlatButton(
            child: Text(i18n(context, "btn_message_paste")),
            onPressed: current == null ? null : _paste,
          ),
          FlatButton(
            child: Text(i18n(context, "btn_cancel")),
            onPressed: _cancel,
          ),
        ],
      ),
    );
  }

  Widget _buildFolders(FoldersLoaded state) {
    final currentFolders = state.folders
        .where((item) => item.parentGuid == current?.guid)
        .toList();
    return ListView.builder(
      itemCount: currentFolders.length,
      itemBuilder: (context, i) => _folder(currentFolders[i]),
    );
  }

  Widget _folder(Folder folder) {
    return ListTile(
      onTap: () => _addToStack(folder),
      leading: FolderHelper.getIcon(folder),
      title: Text(FolderHelper.getTitle(context, folder)),
    );
  }

  _addToStack(Folder folder) {
    stack.add(folder);
    setState(() {});
  }

  _cancel() {
    stack.clear();
    Navigator.pop(context);
  }

  _paste() {
    widget.bloc.add(MoveToFolderMessages(widget.messages, current));
    _cancel();
  }
}
