import 'dart:async';

import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/inject/app_inject.dart';
import 'package:aurora_mail/modules/mail/blocs/compose_bloc/compose_methods.dart';
import 'package:aurora_mail/modules/mail/models/compose_attachment.dart';
import 'package:aurora_mail/modules/mail/models/temp_attachment_upload.dart';
import 'package:aurora_mail/utils/api_utils.dart';
import 'package:aurora_mail/utils/permissions.dart';
import 'package:bloc/bloc.dart';
import 'package:crypto_worker/crypto_worker.dart';
import 'package:flutter/foundation.dart';

import './bloc.dart';

class ComposeBloc extends Bloc<ComposeEvent, ComposeState> {
  ComposeMethods _methods;

  ComposeBloc({@required User user, @required Account account}) {
    _methods = new ComposeMethods(
      user: user,
      account: account,
      pgpWorker: AppInjector.instance.pgpWorker(),
      cryptoStorage: AppInjector.instance.cryptoStorage(),
    );
  }

  @override
  ComposeState get initialState => InitialComposeState();

  @override
  Stream<ComposeState> mapEventToState(
    ComposeEvent event,
  ) async* {
    if (event is SendMessage) yield* _sendMessage(event);
    if (event is SaveToDrafts) yield* _saveToDrafts(event);
    if (event is UploadAttachment) yield* _uploadAttachment(event);
    if (event is StartUpload) yield UploadStarted(event.tempAttachment);
    if (event is EndUpload) yield AttachmentUploaded(event.composeAttachment);
    if (event is GetComposeAttachments) yield* _getComposeAttachments(event);
    if (event is GetContactsAsAttachments)
      yield* _getContactsAsAttachment(event);
    if (event is ErrorUpload)
      yield ComposeError(formatError(event.error, null));
    if (event is EncryptBody) yield* _encryptBody(event);
  }

  Stream<ComposeState> _sendMessage(SendMessage event) async* {
    try {
      yield MessageSending();

      await _methods.sendMessage(
        to: event.to,
        cc: event.cc,
        bcc: event.bcc,
        isHtml: event.isHtml,
        subject: event.subject,
        composeAttachments: event.composeAttachments,
        messageText: event.messageText,
        draftUid: event.draftUid,
        sender:event.sender,
      );

      yield MessageSent();
    } catch (err, s) {
      yield ComposeError(formatError(err, s));
    }
  }

  Stream<ComposeState> _saveToDrafts(SaveToDrafts event) async* {
    try {
      final draftUid = await _methods.saveToDrafts(
        to: event.to,
        cc: event.cc,
        bcc: event.bcc,
        subject: event.subject,
        composeAttachments: event.composeAttachments,
        messageText: event.messageText,
        draftUid: event.draftUid,
      );

      yield MessageSavedInDrafts(draftUid);
    } catch (err, s) {
      yield ComposeError(formatError(err, s));
    }
  }

  Stream<ComposeState> _uploadAttachment(UploadAttachment event) async* {
    try {
      await getStoragePermissions();
    } catch (err) {
      yield ComposeError(err.toString());
    }

    _methods.uploadFile(onUploadStart: (TempAttachmentUpload tempAttachment) {
      add(StartUpload(tempAttachment));
    }, onUploadEnd: (ComposeAttachment attachment) {
      add(EndUpload(attachment));
    }, onError: (dynamic err) {
      add(ErrorUpload(err.toString()));
    });
  }

  Stream<ComposeState> _getComposeAttachments(
      GetComposeAttachments event) async* {
    yield ConvertingAttachments();
    try {
      final composeAttachments =
          await _methods.getComposeAttachments(event.attachments);

      yield ReceivedComposeAttachments(composeAttachments);
    } catch (err, s) {
      yield ComposeError(formatError(err, s));
    }
  }

  Stream<ComposeState> _getContactsAsAttachment(
      GetContactsAsAttachments event) async* {
    yield ConvertingAttachments();
    try {
      final contactsAttachments =
          await _methods.saveContactsAsTempFiles(event.contacts);

      yield ReceivedComposeAttachments(contactsAttachments);
    } catch (err, s) {
      yield ComposeError(formatError(err, s));
    }
  }

  Stream<ComposeState> _encryptBody(EncryptBody event) async* {
    try {
      if (event.encrypt && event.contacts.isEmpty) {
        yield ComposeError(
          "need_contact_fo`r_encrypt",
        );
        return;
      }
      final emails = event.contacts.map((item) {
        final match = RegExp("<(.*)?>").firstMatch(item);
        if (match != null && match.groupCount > 0) {
          return match.group(1);
        } else {
          return item;
        }
      }).toList();
      final encrypted = await _methods.encrypt(
        event.sign,
        event.encrypt,
        event.pass,
        emails,
        event.body,
      );
      final type = event.encrypt ? EncryptType.Encrypt : EncryptType.Sign;
      yield EncryptComplete(encrypted, type);
    } catch (e) {
      if (e is PgpKeyNotFound) {
        yield ComposeError(
          "not_found_keys_for",
          {"users": e.email.join(" , ")},
        );
      } else if (e is PgpInvalidSign) {
        yield ComposeError("invalid_password");
      } else {
        yield ComposeError("error_server_unknown_email");
      }
    }
  }
}
