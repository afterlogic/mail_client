import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/models/folder.dart';
import 'package:aurora_mail/modules/mail/blocs/messages_list_bloc/bloc.dart';
import 'package:aurora_mail/utils/always_non_equal_object.dart';
import 'package:equatable/equatable.dart';

import 'mail_state.dart';

abstract class MailEvent extends Equatable {
  const MailEvent();

  @override
  List<Object> get props => null;
}

// try from DB, if empty - fetch from server
class FetchFolders extends MailEvent with AlwaysNonEqualObject {}

// always from DB (e.g. to update needsInfoUpdate, which controls loading)
class UpdateFolders extends MailEvent {}

// always from server
class RefreshFolders extends MailEvent with AlwaysNonEqualObject {
  final bool updateOther;

  RefreshFolders([this.updateOther = false]);
}

// gets messagesInfo for current folder
// and relevant folders info for all the folders, including current
class RefreshMessages extends MailEvent with AlwaysNonEqualObject {
  final bool updateOther;

  RefreshMessages([this.updateOther = false]);
}

class CheckFoldersMessagesChanges extends MailEvent {}

class SelectFolder extends MailEvent {
  final Folder folder;
  final MessagesFilter filter;

  const SelectFolder(this.folder, {this.filter = MessagesFilter.none});

  @override
  List<Object> get props => [folder.fullNameRaw, filter];
}

class SetSeen extends MailEvent {
  final List<Message> messages;
  final bool isSeen;

  const SetSeen(this.messages, this.isSeen);

  @override
  List<Object> get props => [messages, isSeen];
}

class SetStarred extends MailEvent {
  final List<Message> messages;
  final bool isStarred;

  const SetStarred(this.messages, this.isStarred);

  @override
  List<Object> get props => [messages, isStarred];
}

class AddState extends MailEvent {
  final MailState state;

  AddState(this.state);

  List<Object> get props => state.props;
}
