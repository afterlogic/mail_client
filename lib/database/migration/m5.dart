import 'package:moor_flutter/moor_flutter.dart';

import '../app_database.dart';

Future m5(AppDatabase database, Migrator m) async {
  // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
  await m.issueCustomQuery('DELETE FROM ${database.folders.$tableName};');
}
