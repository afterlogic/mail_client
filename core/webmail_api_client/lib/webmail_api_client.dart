library webmail_api_client;

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:http/io_client.dart';

import 'webmail_api_body.dart';
import 'webmail_api_error.dart';

export 'webmail_api_body.dart';
export 'webmail_api_error.dart';
export 'webmail_api_modules.dart';

class WebMailApi {
  final String moduleName;
  final String hostname;
  final String token;
  static Function(String) onRequest;
  static Function(String) onError;
  static Function(String) onResponse;
  static IOClient _client = IOClient(HttpClient()
    ..badCertificateCallback = ((X509Certificate cert, String host, int port) {
      return false;
    }));

  String get apiUrl => "$hostname/?Api/";

  Map<String, String> get headerWithToken => {'Authorization': 'Bearer $token'};

  WebMailApi({
    @required this.moduleName,
    @required this.hostname,
    this.token,
  }) : assert(moduleName != null && hostname != null);

  static final _authErrorStreamCtrl = StreamController<void>.broadcast();

  // fired when token is invalid (e.g. to send user back to login)
  static Stream<void> get authErrorStream =>
      _authErrorStreamCtrl.stream.asBroadcastStream();

  static Map<String, String> getHeaderWithToken(String token) {
    return {'Authorization': 'Bearer $token'};
  }

  // getRawResponse in case AuthenticatedUserId is required, which is outside Result objects
  Future post(WebMailApiBody body,
      {bool useToken, bool getRawResponse = false}) async {
    Map<String, String> headers;
    final id = "MODULE: ${moduleName ?? body.module}\nMETHOD: ${body.method}";
    if (useToken == false || token == null) {
      headers = null;
    } else {
      headers = {'Authorization': 'Bearer $token'};
    }
    final start = DateTime.now().millisecondsSinceEpoch;
    if (onRequest != null)
      onRequest("$id\nURL:$apiUrl\nPARAMETERS:${body.parameters}");

    final rawResponse = await _client.post(apiUrl,
        headers: headers, body: body.toMap(moduleName));

    final res = json.decode(rawResponse.body);

    if (res["Result"] != null && (res["Result"] != false || getRawResponse)) {
      if (onResponse != null)
        onResponse(
            "$id\nDELAY: ${DateTime.now().millisecondsSinceEpoch - start}\nSTATUS:${rawResponse.statusCode}");
      if (getRawResponse)
        return res;
      else
        return res["Result"];
    } else {
      if (onError != null) onError("$id\n${rawResponse.body}");
      if (res["ErrorCode"] == 102) {
        _authErrorStreamCtrl.add(102);
      }
      throw WebMailApiError(res);
    }
  }

  Future multiPart(WebMailApiBody body, MultipartFile file,
      {bool useToken, bool getRawResponse = false}) async {
    Map<String, String> headers;
    final id = "MODULE: ${moduleName ?? body.module}\nMETHOD: ${body.method}";
    if (useToken == false || token == null) {
      headers = null;
    } else {
      headers = {'Authorization': 'Bearer $token'};
    }
    final start = DateTime.now().millisecondsSinceEpoch;
    if (onRequest != null)
      onRequest("$id\nURL:$apiUrl\nPARAMETERS:${body.parameters}");

    final request = MultipartRequest("POST", Uri.parse(apiUrl));

    request.headers.addAll(headers);
    request.fields.addAll(body.toMap(moduleName));
    request.files.add(file);
    final rawResponse = await request.send();
    final responseBody = await rawResponse.stream.bytesToString();
    final res = json.decode(responseBody);

    if (res["Result"] != null && (res["Result"] != false || getRawResponse)) {
      if (onResponse != null)
        onResponse(
            "$id\nDELAY: ${DateTime.now().millisecondsSinceEpoch - start}\nSTATUS:${rawResponse.statusCode}");
      if (getRawResponse)
        return res;
      else
        return res["Result"];
    } else {
      if (onError != null) onError("$id\n${responseBody}");
      if (res["ErrorCode"] == 102) {
        _authErrorStreamCtrl.add(102);
      }
      throw WebMailApiError(res);
    }
  }
}
