import 'package:aurora_mail/database/app_database.dart';
import 'package:flutter/cupertino.dart';

enum FolderType {
  inbox,
  sent,
  drafts,
  spam,
  trash,
  virus,
  starred,
  template,
  system,
  user,
  unknown,
}

class Folder {
  final String guid;

  final String parentGuid;

  final int accountLocalId;

  final int type;

  final FolderType folderType;

  final int order;

  final String name;

  final String fullName;

  final String fullNameRaw;

  final String fullNameHash;

  final String folderHash;

  final String delimiter;

  final bool needsInfoUpdate;

  final bool isSystemFolder;

  final bool isSubscribed;

  final bool isSelectable;

  final bool exists;

  final bool extended;

  final bool alwaysRefresh;

  final int count;

  final int unread;
  final String nameSpace;

  Folder({
    @required this.guid,
    @required this.parentGuid,
    @required this.type,
    @required this.folderType,
    @required this.order,
    @required this.name,
    @required this.fullName,
    @required this.fullNameRaw,
    @required this.fullNameHash,
    @required this.folderHash,
    @required this.delimiter,
    @required this.needsInfoUpdate,
    @required this.isSystemFolder,
    @required this.isSubscribed,
    @required this.isSelectable,
    @required this.exists,
    @required this.extended,
    @required this.alwaysRefresh,
    @required this.count,
    @required this.unread,
    @required this.nameSpace,
    @required this.accountLocalId,
  });

  String get viewName {
    if (fullName.startsWith(nameSpace)) {
      return fullName.substring(nameSpace.length);
    } else {
      return fullName;
    }
  }

  static FolderType getFolderTypeFromNumber(int num) {
    if (num == null) {
      return null;
    }
    switch (num) {
      case 1:
        return FolderType.inbox;
      case 2:
        return FolderType.sent;
      case 3:
        return FolderType.drafts;
      case 4:
        return FolderType.spam;
      case 5:
        return FolderType.trash;
      case 6:
        return FolderType.virus;
      case 7:
        return FolderType.starred;
      case 8:
        return FolderType.template;
      case 9:
        return FolderType.system;
      case 10:
        return FolderType.user;
      default:
        return FolderType.unknown;
    }
  }

  static int getNumberFromFolderType(FolderType num) {
    if (num == null) {
      return null;
    }
    switch (num) {
      case FolderType.inbox:
        return 1;
      case FolderType.sent:
        return 2;
      case FolderType.drafts:
        return 3;
      case FolderType.spam:
        return 4;
      case FolderType.trash:
        return 5;
      case FolderType.virus:
        return 6;
      case FolderType.starred:
        return 7;
      case FolderType.template:
        return 8;
      case FolderType.system:
        return 9;
      case FolderType.user:
        return 10;
      default:
        return -1;
    }
  }

  static List<Folder> getFoldersObjectsFromDb(List<LocalFolder> localFolders) {
    try {
      return localFolders.map((localFolder) {
        return getFolderObjectsFromDb(localFolder);
      }).toList();
    } catch (err, s) {
      print("getFolderObjectsFromDb err: $err");
      print("getFolderObjectsFromDb s: $s");
      return null;
    }
  }

  static Folder getFolderObjectsFromDb(LocalFolder localFolder) {
    return Folder(
      accountLocalId: localFolder.accountLocalId,
      nameSpace: localFolder.namespace,
      guid: localFolder.guid,
      parentGuid: localFolder.parentGuid,
      type: localFolder.type,
      folderType: getFolderTypeFromNumber(localFolder.type),
      order: localFolder.folderOrder,
      name: localFolder.name,
      fullName: localFolder.fullName,
      fullNameRaw: localFolder.fullNameRaw,
      fullNameHash: localFolder.fullNameHash,
      folderHash: localFolder.folderHash,
      delimiter: localFolder.delimiter,
      needsInfoUpdate: localFolder.needsInfoUpdate,
      isSystemFolder: localFolder.isSystemFolder,
      isSubscribed: localFolder.isSubscribed,
      isSelectable: localFolder.isSelectable,
      exists: localFolder.folderExists,
      extended: localFolder.extended,
      alwaysRefresh: localFolder.alwaysRefresh,
      count: localFolder.count,
      unread: localFolder.unread,
    );
  }
}
