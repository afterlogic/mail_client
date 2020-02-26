import 'package:aurora_mail/database/app_database.dart';
import 'package:moor_flutter/moor_flutter.dart';

import 'pgp_key_model.dart';

part 'pgp_key_dao.g.dart';

@UseDao(tables: [PgpKeyModel])
class PgpKeyDao extends DatabaseAccessor<AppDatabase> with _$PgpKeyDaoMixin {
  PgpKeyDao(AppDatabase db) : super(db);
  String _other;

  Future<List<LocalPgpKey>> getPgpKeys(bool isPrivate) {
    return _forOther(select(pgpKeyModel)
          ..where((key) => key.isPrivate.equals(isPrivate)))
        .get();
  }

  Future<LocalPgpKey> getPgpKey(String email, bool isPrivate) {
    return _forOther(select(pgpKeyModel)
          ..where((pgpKey) => pgpKey.mail.equals(email))
          ..where((pgpKey) => pgpKey.isPrivate.equals(isPrivate)))
        .getSingle();
  }

  Future<void> addPgpKey(LocalPgpKey key) {
    return batch((b) {
      return b.insert(pgpKeyModel, key);
    });
  }

  Future<int> deletePgpKey(String email, bool isPrivate) {
    return _forOther(delete(pgpKeyModel)
          ..where((pgpKey) => pgpKey.mail.equals(email))
          ..where((pgpKey) => pgpKey.isPrivate.equals(isPrivate)))
        .go();
  }

  Future<int> deleteAll() {
    return _forOther(delete(pgpKeyModel)).go();
  }

  Future<void> addPgpKeys(List<LocalPgpKey> keys) {
    return batch((b) {
      return b.insertAll(pgpKeyModel, keys);
    });
  }

  T _forOther<T extends SingleTableQueryMixin<$PgpKeyModelTable, LocalPgpKey>>(
      T statement) {
    return statement..where((pgpKey) => pgpKey.other.equals(_other));
  }

  setOther(String id) {
    _other = id;
  }
}
