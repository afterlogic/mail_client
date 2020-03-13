import 'package:aurora_mail/database/account_identity/account_identity_table.dart';
import 'package:aurora_mail/database/aliases/aliases_table.dart';
import 'package:aurora_mail/database/folders/folders_table.dart';
import 'package:aurora_mail/database/mail/mail_table.dart';
import 'package:aurora_mail/database/pgp/pgp_key_model.dart';
import 'package:aurora_mail/modules/contacts/contacts_domain/models/contacts_storage_model.dart';
import 'package:aurora_mail/modules/contacts/contacts_impl_domain/services/db/contacts/contacts_table.dart';
import 'package:aurora_mail/modules/contacts/contacts_impl_domain/services/db/contacts/converters/list_string_converter.dart';
import 'package:aurora_mail/modules/contacts/contacts_impl_domain/services/db/groups/contacts_groups_table.dart';
import 'package:aurora_mail/modules/contacts/contacts_impl_domain/services/db/storages/contacts_storages_table.dart';
import 'package:aurora_mail/modules/contacts/contacts_impl_domain/services/db/storages/converters/contacts_info_converter.dart';
import 'package:moor_flutter/moor_flutter.dart';

import 'accounts/accounts_table.dart';
import 'users/users_table.dart';

part 'app_database.g.dart';

typedef _Migration = Future Function(Migrator migrator);

class DBInstances {
  static final appDB = new AppDatabase();
}

@UseMoor(tables: [
  Mail,
  Folders,
  Users,
  Accounts,
  Contacts,
  ContactsGroups,
  ContactsStorages,
  PgpKeyModel,
  AccountIdentityTable,
  AliasesTable,
])
class AppDatabase extends _$AppDatabase {
  AppDatabase()
      : super(FlutterQueryExecutor.inDatabaseFolder(path: 'app_db.sqlite'));

  Map<int, _Migration> get _migrationMap => {};

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (Migrator m) async {
          await m.createAll();
          final columns = mail.$columns.map((item) => item.escapedName).join(",");
          await m.issueCustomQuery(
              "CREATE VIRTUAL TABLE fts_${mail.actualTableName} USING fts3 (content='${mail.actualTableName}', $columns)");
        },
        onUpgrade: (Migrator m, int from, int to) async {
          final migrationMap = _migrationMap;
          for (var i = from; i < to; i++) {
            await migrationMap[i](m);
          }
        },
      );

  // you should bump this number whenever you change or add a table definition. Migrations
  // are covered later in this readme.
  @override
  int get schemaVersion => 1;
}
