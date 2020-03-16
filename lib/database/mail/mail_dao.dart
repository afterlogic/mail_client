import 'dart:convert';
import 'dart:math';

import 'package:aurora_mail/models/message_info.dart';
import 'package:aurora_mail/modules/mail/repository/search_util.dart';
import 'package:moor_flutter/moor_flutter.dart';

import '../app_database.dart';
import 'mail_table.dart';

part 'mail_dao.g.dart';

// TODO in all daos, make sure to select specific account's messages/folders

@UseDao(tables: [Mail])
class MailDao extends DatabaseAccessor<AppDatabase> with _$MailDaoMixin {
  MailDao(AppDatabase db) : super(db);

//  Future<List<Message>> getMessages(String folder) {
//    return (select(mail)
//          ..where((m) => m.folder.equals(folder))
//          ..orderBy([
//            (m) => OrderingTerm(expression: m.receivedOrDateTimeStampInUTC)
//          ]))
//        .get();
//  }

  Future _updateVirtualTable() async {
    final columns = mail.$columns.map((item) => item.escapedName).join(",");
    final delete = "DELETE FROM fts_${mail.actualTableName}";
    await customInsert(delete);
    var insert =
        "INSERT INTO fts_${mail.actualTableName} ($columns) SELECT $columns FROM ${mail.actualTableName}";
    await customInsert(insert);
  }

  Future<Stream<List<Message>>> getMessages(
    String folder,
    int userLocalId,
    String searchTerm,
    SearchPattern searchPattern,
    int accountEntityId,
    bool starredOnly,
    bool unreadOnly,
  ) async {
    List<Variable> params = [];
    final fields = <GeneratedColumn>{};
    fields.add(mail.uid);
    fields.add(mail.localId);
    fields.add(mail.parentUid);
    fields.add(mail.flagsInJson);
    fields.add(mail.subject);
    fields.add(mail.fromToDisplay);
    fields.add(mail.toToDisplay);
    fields.add(mail.hasAttachments);
    fields.add(mail.timeStampInUTC);
    fields.add(mail.folder);

    var query = "SELECT ${fields.map((item) => item.escapedName).join(",")} FROM ";
    if (searchPattern != SearchPattern.Default ||
        searchTerm?.isNotEmpty == true) {
      query += "fts_";
      await _updateVirtualTable();
    }
    query += "${mail.actualTableName} WHERE ";
    query += "${mail.accountEntityId.escapedName} = ? ";
    params.add(Variable.withInt(accountEntityId));

    if (searchPattern == SearchPattern.Email) {
      query +=
          "AND (${mail.toForSearch.escapedName} LIKE ? OR ${mail.fromForSearch.escapedName} LIKE ? OR ${mail.ccForSearch.escapedName} LIKE ? OR ${mail.bccForSearch.escapedName} LIKE ?) ";
      params.add(Variable.withString("%$searchTerm%"));
      params.add(Variable.withString("%$searchTerm%"));
      params.add(Variable.withString("%$searchTerm%"));
      params.add(Variable.withString("%$searchTerm%"));
    } else {
      query += "AND ${mail.folder.escapedName} = ? ";
      params.add(Variable.withString(folder));

      if (searchTerm != null && searchTerm.isNotEmpty) {
        query +=
            "AND (${mail.subject.escapedName} LIKE ? OR ${mail.toForSearch.escapedName} LIKE ? OR ${mail.fromForSearch.escapedName} LIKE ? OR ${mail.ccForSearch.escapedName} LIKE ? OR ${mail.bccForSearch.escapedName} LIKE ? OR ${mail.rawBody.escapedName} LIKE ? OR ${mail.attachmentsForSearch.escapedName} LIKE ?) ";
        params.add(Variable.withString("%$searchTerm%"));
        params.add(Variable.withString("%$searchTerm%"));
        params.add(Variable.withString("%$searchTerm%"));
        params.add(Variable.withString("%$searchTerm%"));
        params.add(Variable.withString("%$searchTerm%"));
        params.add(Variable.withString("%$searchTerm%"));
        params.add(Variable.withString("%$searchTerm%"));
      }
    }
    if (starredOnly) {
      query += "AND ${mail.flagsInJson.escapedName} LIKE ? ";
      params.add(Variable.withString("%\\flagged%"));
    }
    //todo
    if (unreadOnly) {
      query += "AND ${mail.flagsInJson.escapedName} NOT LIKE ? ";
      params.add(Variable.withString("%\\seen%"));
    }

    query += "ORDER BY ${mail.timeStampInUTC.escapedName} DESC ";
//    query += "LIMIT ? OFFSET ? ";
//
//    params.add(Variable.withInt(limit));
//    params.add(Variable.withInt(offset));

    return customSelectQuery(query, variables: params, readsFrom: {mail})
        .watch()
        .map((list) {
      return list.map((item) {
        return Message.fromData(item.data, db);
      }).toList();
    });
  }

  Future<Message> getMessage(int localId) {
    return (select(mail)..where((item) => item.localId.equals(localId)))
        .getSingle();
  }

  Future<void> addMessages(List<Message> newMessages) async {
    try {
      await into(mail).insertAll(newMessages);
    } catch (err) {
//      print("addMessages err: ${err}");
    }
  }

  Future<void> updateMessagesFlags(List<MessageInfo> infos) async {
    return transaction(() async {
      for (final info in infos) {
        await (update(mail)..where((m) => m.uid.equals(info.uid))).write(
            new MailCompanion(flagsInJson: Value(json.encode(info.flags))));
      }
    });
  }

  Future deleteMessages(List<int> uids, String folderRawName) async {
    final step = 100;
    for (int i = 0; i <= uids.length ~/ step; i++) {
      final start = i * step;
      final end = min(start + step, uids.length);
      await (delete(mail)
            ..where((m) => m.uid.isIn(uids.getRange(start, end)))
            ..where((m) => m.folder.equals(folderRawName)))
          .go();
    }
  }

  Future<int> deleteMessagesFromRemovedFolders(
      List<String> removedFoldersRawNames) async {
    final deletedMessages = await (delete(mail)
          ..where((m) => isIn(m.folder, removedFoldersRawNames)))
        .go();

    print("deleted messages from removed folders: $deletedMessages");

    return deletedMessages;
  }

  Future<int> deleteMessagesOfUser(int userLocalId) {
    return (delete(mail)..where((m) => m.userLocalId.equals(userLocalId))).go();
  }
}
