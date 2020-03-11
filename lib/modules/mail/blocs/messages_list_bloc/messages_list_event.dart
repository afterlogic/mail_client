import 'package:aurora_mail/models/folder.dart';
import 'package:aurora_mail/modules/mail/blocs/messages_list_bloc/bloc.dart';
import 'package:aurora_mail/modules/mail/repository/search_util.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class MessagesListEvent extends Equatable {
  const MessagesListEvent();

  @override
  List<Object> get props => [];
}

class SubscribeToMessages extends MessagesListEvent {
  final Folder currentFolder;
  final MessagesFilter filter;
  final String searchTerm;
  final SearchPattern pattern;

  const SubscribeToMessages(this.currentFolder, this.filter,
      [this.searchTerm, this.pattern]);

  @override
  List<Object> get props => [currentFolder, filter, searchTerm];
}

class StopMessagesRefresh extends MessagesListEvent {}

class DeleteMessages extends MessagesListEvent {
  final List<int> uids;
  final String folderRawName;

  const DeleteMessages({@required this.uids, @required this.folderRawName});

  @override
  List<Object> get props => [uids, folderRawName];
}
