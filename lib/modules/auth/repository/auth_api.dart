import 'dart:convert';

import 'package:aurora_mail/config.dart';
import 'package:aurora_mail/database/accounts/accounts_table.dart';
import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/models/api_body.dart';
import 'package:aurora_mail/utils/api_utils.dart';
import 'package:http/http.dart' as http;
import 'package:webmail_api_client/webmail_api_client.dart';

class AuthApi {
  Future<String> autoDiscoverHostname(String email) async {
    try {
      final url = "$AUTO_DISCOVER_URL?email=$email";
      final res = await http.get(url);
      final resBody = json.decode(res.body);
      return resBody["url"] as String;
    } catch (err) {
      return null;
    }
  }

  Future<User> login(String email, String password, String hostname) async {
    final parameters =
        json.encode({"Login": email, "Password": password, "Pattern": ""});

    final body =
        new ApiBody(module: "Core", method: "Login", parameters: parameters)
            .toMap();

    final res = await http.post("$hostname/?Api/", body: body);

    final resBody = json.decode(res.body);
    if (resBody['Result'] != null && resBody['Result']['AuthToken'] is String) {
      final token = resBody['Result']['AuthToken'] as String;
      final id = resBody['AuthenticatedUserId'] as int;

      return new User(
        localId: null,
        serverId: id,
        token: token,
        hostname: hostname,
      );
    } else {
      throw WebMailApiError(resBody);
    }
  }

  Future<List<Account>> getAccounts(int userIdFromServer) async {
    final parameters = json.encode({"UserId": userIdFromServer});

    final body = new ApiBody(
        module: "Mail", method: "GetAccounts", parameters: parameters);

    final res = await sendRequest(body);

    if (res['Result'] is List) {
      final accounts = Accounts.getAccountsObjFromServer(res['Result'] as List);

      return accounts;
    } else {
      throw WebMailApiError(res);
    }
  }
}
