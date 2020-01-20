import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/database/mail/mail_dao.dart';
import 'package:aurora_mail/models/folder.dart';
import 'package:aurora_mail/modules/mail/repository/mail_api.dart';
import 'package:flutter/foundation.dart';

class MessagesListMethods {
  final _mailDao = new MailDao(DBInstances.appDB);
  MailApi _mailApi;

  MessagesListMethods({@required User user, @required Account account}) {
    _mailApi = new MailApi(user: user, account: account);
  }

  Stream<List<Message>> subscribeToMessages(Folder folder, bool isStarred, User user) {
    return _mailDao.watchMessages(folder.fullNameRaw, user.localId, isStarred);
  }

  Future<void> deleteMessages(List<int> uids, String folderRawName) async {
    final futures = [
      _mailApi.deleteMessages(uids: uids, folderRawName: folderRawName),
      _mailDao.deleteMessages(uids, folderRawName),
    ];

    await Future.wait(futures);
  }
}
