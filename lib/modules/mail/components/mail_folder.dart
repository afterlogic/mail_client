import 'package:aurora_mail/models/folder.dart';
import 'package:aurora_mail/modules/app_store.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class MailFolder extends StatelessWidget {
  final Folder mailFolder;
  final List<MailFolder> children;

  const MailFolder({Key key, @required this.mailFolder, this.children})
      : super(key: key);

  IconData _getFolderIcon(FolderTypes type) {
    switch (type) {
      case FolderTypes.inbox:
        return Icons.inbox;
      case FolderTypes.sent:
        return Icons.send;
      case FolderTypes.drafts:
        return Icons.drafts;
      case FolderTypes.spam:
        return MdiIcons.emailAlert;
      case FolderTypes.trash:
        return MdiIcons.trashCanOutline;
      case FolderTypes.virus:
        return Icons.bug_report;
      case FolderTypes.starred:
        return Icons.star;
      case FolderTypes.template:
        return MdiIcons.fileDocumentEditOutline;
      case FolderTypes.system:
        return Icons.devices;
      case FolderTypes.user:
        return Icons.person;
      case FolderTypes.unknown:
        return Icons.device_unknown;
      default:
        return null;
    }
  }

  Widget _buildMessageCounter(BuildContext context) {
    if (mailFolder.unread != null && mailFolder.unread > 0 ||
        mailFolder.folderType == FolderTypes.drafts &&
            mailFolder.count != null &&
            mailFolder.count > 0) {
      return ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(50.0)),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 6.0, horizontal: 10.0),
          color: Theme.of(context).accentColor,
          child: Text(
            mailFolder.folderType == FolderTypes.drafts
                ? mailFolder.count.toString()
                : mailFolder.unread.toString(),
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
    } else {
      return null;
    }
  }

  void _selectFolder(BuildContext context) {
    Navigator.pop(context);
    AppStore.foldersState.selectFolder(mailFolder);
  }

  @override
  Widget build(BuildContext context) {
    if (mailFolder.isSubscribed == true) {
      return Column(
        children: <Widget>[
          ListTile(
            selected: mailFolder.localId ==
                AppStore.foldersState.selectedFolder.localId,
            leading: Icon(_getFolderIcon(mailFolder.folderType)),
            title: Text(mailFolder.name),
            trailing: _buildMessageCounter(context),
            onTap: () => _selectFolder(context),
          ),
          Padding(
            padding: EdgeInsets.only(left: 40.0),
            child: Column(
              children: children,
            ),
          )
        ],
      );
    } else {
      return SizedBox();
    }
  }
}
