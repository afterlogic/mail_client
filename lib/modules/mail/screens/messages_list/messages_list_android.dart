import 'dart:async';
import 'dart:io';

import 'package:aurora_mail/background/background_helper.dart';
import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/models/folder.dart';
import 'package:aurora_mail/modules/auth/blocs/auth_bloc/bloc.dart';
import 'package:aurora_mail/modules/contacts/blocs/contacts_bloc/bloc.dart';
import 'package:aurora_mail/modules/mail/blocs/mail_bloc/bloc.dart';
import 'package:aurora_mail/modules/mail/blocs/messages_list_bloc/bloc.dart';
import 'package:aurora_mail/modules/mail/models/compose_actions.dart';
import 'package:aurora_mail/modules/mail/screens/compose/compose_route.dart';
import 'package:aurora_mail/modules/mail/screens/message_view/message_view_route.dart';
import 'package:aurora_mail/modules/mail/screens/messages_list/components/main_drawer.dart';
import 'package:aurora_mail/modules/mail/screens/messages_list/components/selection_controller.dart';
import 'package:aurora_mail/modules/mail/screens/messages_list/components/stream_pagination_list.dart';
import 'package:aurora_mail/modules/mail/screens/messages_list/dialog/advanced_search.dart';
import 'package:aurora_mail/modules/settings/blocs/settings_bloc/bloc.dart';
import 'package:aurora_mail/shared_ui/confirmation_dialog.dart';
import 'package:aurora_mail/shared_ui/mail_bottom_app_bar.dart';
import 'package:aurora_mail/utils/base_state.dart';
import 'package:aurora_mail/utils/internationalization.dart';
import 'package:aurora_mail/utils/show_dialog.dart';
import 'package:aurora_mail/utils/show_snack.dart';
import 'package:aurora_ui_kit/aurora_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'components/mail_app_bar.dart';
import 'components/mail_folder.dart';
import 'components/message_item.dart';

class MessagesListAndroid extends StatefulWidget {
  final String initSearch;
  final int openMessageId;

  const MessagesListAndroid({this.initSearch, this.openMessageId});

  @override
  _MessagesListAndroidState createState() => _MessagesListAndroidState();

  static Function(List<File> files, List<String> text) onShare;
  static List shareHolder;
}

class _MessagesListAndroidState extends BState<MessagesListAndroid> {
  MessagesListBloc _messagesListBloc;
  MailBloc _mailBloc;
  ContactsBloc _contactsBloc;
  bool isSearch = false;
  Completer _refreshCompleter;
  Folder _selectedFolder;
  final appBarKey = GlobalKey<MailAppBarState>();
  final _refreshKey = GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    super.initState();

    _initBlocs();
    MessagesListAndroid.onShare = (files, text) {
      if (files?.isNotEmpty == true || text?.isNotEmpty == true) {
        Navigator.pushNamed(
          context,
          ComposeRoute.name,
          arguments: ComposeScreenArgs(
            mailBloc: _mailBloc,
            contactsBloc: _contactsBloc,
            composeAction: InitWithAttachment(files, text),
          ),
        );
      }
    };
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (MessagesListAndroid.shareHolder != null) {
        MessagesListAndroid.onShare(
            MessagesListAndroid.shareHolder[0] as List<File>,
            MessagesListAndroid.shareHolder[1] as List<String>);
        MessagesListAndroid.shareHolder = null;
      }
    });
    if (widget.openMessageId != null) {
      openMessage(widget.openMessageId);
    }
    BackgroundHelper.addOnAlarmObserver(false, onAlarm);
    BackgroundHelper.addOnEndAlarmObserver(false, onEndAlarm);
  }

  openMessage(int uid) async {
    await Future.delayed(Duration(milliseconds: 1));
    if (widget.openMessageId != null) {
      try {
        final message = await _mailBloc.getMessageByUid(uid);
        await _onMessageSelected(message);
      } catch (e) {
        print(e);
      }
    }
  }

  @override
  void didUpdateWidget(MessagesListAndroid oldWidget) {
    super.didUpdateWidget(oldWidget);
    _initBlocs();
  }

  @override
  void dispose() {
    super.dispose();
    _messagesListBloc.close();
    MessagesListAndroid.onShare = null;
    BackgroundHelper.removeOnAlarmObserver(onAlarm);
    BackgroundHelper.removeOnAlarmObserver(onEndAlarm);
  }

  void _initBlocs() {
    final authBloc = BlocProvider.of<AuthBloc>(context);

    _messagesListBloc = new MessagesListBloc(
      user: authBloc.currentUser,
      account: authBloc.currentAccount,
    );
    _mailBloc = BlocProvider.of<MailBloc>(context);
    _contactsBloc = BlocProvider.of<ContactsBloc>(context);

    _mailBloc.init(
      authBloc.currentUser,
      authBloc.currentAccount,
    );

    _mailBloc.add(FetchFolders());
  }

  void _showError(BuildContext ctx, String err) {
    showSnack(context: ctx, scaffoldState: Scaffold.of(ctx), msg: err);
  }

  Future _onMessageSelected(Message _message) async {
    final message = await _mailBloc.getFullMessage(_message.localId);
    final draftsFolder = await _mailBloc.getFolderByType(FolderType.drafts);
    print(message.localId);
    if (draftsFolder != null && message.folder == draftsFolder.fullNameRaw) {
      Navigator.pushNamed(
        context,
        ComposeRoute.name,
        arguments: ComposeScreenArgs(
          mailBloc: _mailBloc,
          contactsBloc: _contactsBloc,
          composeAction: OpenFromDrafts(message, message.uid),
        ),
      );
    } else {
      Navigator.pushNamed(
        context,
        MessageViewRoute.name,
        arguments: MessageViewScreenArgs(
          message: message,
          mailBloc: _mailBloc,
          messagesListBloc: _messagesListBloc,
          contactsBloc: _contactsBloc,
        ),
      );
    }
  }

  void _deleteMessage(Message message) {
    _messagesListBloc.add(DeleteMessages(messages: [message]));
  }

  void _unreadMessage(Message message, bool isUnread) {
    _mailBloc.add(SetSeen([message], isUnread));
  }

  void _dispatchPostFoldersLoadedAction(FoldersLoaded state) {
    switch (state.postAction) {
      case PostFolderLoadedAction.subscribeToMessages:
        _messagesListBloc.add(SubscribeToMessages(
          state.selectedFolder,
          state.filter,
        ));
        break;
      case PostFolderLoadedAction.stopMessagesRefresh:
        _messagesListBloc.add(StopMessagesRefresh());
        break;
    }
  }

  void _setStarred(Message message, bool isStarred) {
    _mailBloc.add(SetStarred([message], isStarred));
  }

  void _showAllMessages(BuildContext context) {
    _mailBloc.add(SelectFolder(_selectedFolder));
  }

  @override
  Widget build(BuildContext context) {
    final authKey =
        BlocProvider.of<AuthBloc>(context).currentAccount.localId.toString();
    return MultiBlocProvider(
      key: Key(authKey),
      providers: [
        BlocProvider<MessagesListBloc>.value(value: _messagesListBloc),
        BlocProvider<MailBloc>.value(value: _mailBloc),
        BlocProvider<ContactsBloc>.value(value: _contactsBloc),
      ],
      child: BlocListener<AuthBloc, AuthState>(
        condition: (prev, next) {
          return next is InitializedUserAndAccounts;
        },
        listener: (BuildContext context, AuthState state) {
          _initBlocs();
          setState(() {});
        },
        child: Scaffold(
          appBar: MailAppBar(
              key: appBarKey,
              initSearch: widget.initSearch,
              selectionController: selectionController,
              onSearch: (value) {
                isSearch = value;
                setState(() {});
              }),
          drawer: MainDrawer(),
          body: MultiBlocListener(
            listeners: [
              BlocListener(
                bloc: _messagesListBloc,
                listener: (BuildContext context, state) {
                  if (state is MailError) _showError(context, state.errorMsg);
                  if (state is MessagesDeleted) {
                    _startRefresh();
                    _mailBloc.add(RefreshMessages(_refreshCompleter));
                  }
                },
              ),
              BlocListener(
                bloc: _mailBloc,
                listener: (BuildContext context, state) {
                  if (state is FoldersLoaded) {
                    if (state.isProgress == true) {
                      _startRefresh();
                    }
                    setState(() => _selectedFolder = state.selectedFolder);
                    if (state.postAction != null) {
                      _dispatchPostFoldersLoadedAction(state);
                    }
                  }
                },
              ),
              BlocListener<SettingsBloc, SettingsState>(
                condition: (prev, next) {
                  if (prev is SettingsLoaded &&
                      next is SettingsLoaded &&
                      prev.darkThemeEnabled != next.darkThemeEnabled) {
                    return false;
                  } else {
                    return true;
                  }
                },
                listener: (BuildContext context, state) {
                  if (state is SettingsLoaded) {
                    _startRefresh();
                    _mailBloc.add(RefreshMessages(_refreshCompleter));
                  }
                },
              ),
            ],
            child: RefreshIndicator(
              key: _refreshKey,
              onRefresh: () {
                _startRefresh();
                if (isBackgroundRefresh) {
                  isBackgroundRefresh = false;
                } else {
                  _mailBloc.add(RefreshMessages(_refreshCompleter));
                }
                return _refreshCompleter.future;
              },
              backgroundColor: Colors.white,
              color: Colors.black,
              child: BlocBuilder<MessagesListBloc, MessagesListState>(
                  bloc: _messagesListBloc,
                  condition: (prevState, state) =>
                      state is SubscribedToMessages,
                  builder: (context, state) {
                    Widget child;
                    if (state is SubscribedToMessages) {
                      child = _buildMessagesStream(
                        state.stream,
                        state.filter,
                        state.isSent,
                        state.key,
                        state.folder,
                      );
                    } else {
                      child = _buildMessagesLoading();
                    }
                    return AnimatedSwitcher(
                      duration: Duration(milliseconds: 300),
                      child: child,
                    );
                  }),
            ),
          ),
          bottomNavigationBar:
              MailBottomAppBar(selectedRoute: MailBottomAppBarRoutes.mail),
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          floatingActionButton: AMFloatingActionButton(
            child: Icon(
              MdiIcons.pen,
              color: theme.appBarTheme.iconTheme.color,
            ),
            onPressed: () => Navigator.pushNamed(context, ComposeRoute.name,
                arguments: ComposeScreenArgs(
                  mailBloc: _mailBloc,
                  contactsBloc: _contactsBloc,
                )),
          ),
        ),
      ),
    );
  }

  Widget _buildMessagesLoading() => Center(child: CircularProgressIndicator());

  final selectionController = SelectionController<int, Message>();

  Widget _buildMessagesStream(
    Stream<List<Message>> Function(int page) stream,
    MessagesFilter filter,
    bool isSent,
    String key,
    String folder,
  ) {
    return Column(
      children: <Widget>[
        if (isSearch)
          FlatButton(
            onPressed: () async {
              final result = await dialog(
                context: context,
                builder: (_) =>
                    AdvancedSearch(appBarKey.currentState.searchText),
              );
              if (result is String && result.isNotEmpty) {
                appBarKey.currentState.search(result);
              }
            },
            child: Text(i18n(context, "btn_message_advanced_search")),
          ),
        if (filter == MessagesFilter.unread)
          Column(
            children: <Widget>[
              SizedBox(height: 12.0),
              Text(i18n(context, "messages_filter_unread")),
              FlatButton(
                child: Text(i18n(context, "btn_show_all")),
                textColor: theme.accentColor,
                onPressed: () => _showAllMessages(context),
              )
            ],
          ),
        Flexible(
          child: StreamPaginationList(
            key: Key(key),
            folder: folder,
            selectionController: selectionController,
            header: ([FolderType.spam, FolderType.trash]
                        .contains(_selectedFolder.folderType) &&
                    !isSearch)
                ? _emptyFolder
                : null,
            builder: (context, item, threads) {
              return MessageItem(
                isSent,
                item,
                threads.where((t) => t.parentUid == item.uid).toList(),
                selectionController: selectionController,
                key: Key(item.localId.toString()),
                onItemSelected: (Message item) => _onMessageSelected(item),
                onStarMessage: _setStarred,
                onDeleteMessage: _deleteMessage,
                onUnreadMessage: _unreadMessage,
              );
            },
            progress: Padding(
              padding: EdgeInsets.all(20),
              child: Center(child: CircularProgressIndicator()),
            ),
            onError: (context, e) {
              _showError(context, e.toString());
              return SizedBox.shrink();
            },
            empty: (context) {
              if (_selectedFolder != null && _selectedFolder.needsInfoUpdate) {
                return Padding(
                  padding: EdgeInsets.all(20),
                  child: _buildMessagesLoading(),
                );
              }
              return Padding(
                padding: const EdgeInsets.only(top: 100.0),
                child: Center(child: Text(i18n(context, "messages_empty"))),
              );
            },
            fetch: stream,
          ),
        ),
      ],
    );
  }

  Widget _emptyFolder(int messageCount) {
    if (messageCount == null || messageCount == 0) {
      return SizedBox.shrink();
    }
    final emptyFolder =
        Folder.getFolderTypeFromNumber(_selectedFolder.type) == FolderType.trash
            ? "btn_message_empty_trash_folder"
            : "btn_message_empty_spam_folder";
    return ListTile(
      leading: Icon(Icons.delete_forever),
      title: Text(i18n(context, emptyFolder)),
      onTap: messageCount == 0
          ? null
          : () async {
              final delete = await ConfirmationDialog.show(
                context,
                i18n(context, emptyFolder),
                i18n(
                  context,
                  "hint_message_empty_folder",
                  {"folder": FolderHelper.getTitle(context, _selectedFolder)},
                ),
                i18n(context, "btn_delete"),
                destructibleAction: true,
              );
              if (delete == true) {
                _messagesListBloc.add(EmptyFolder(_selectedFolder.fullNameRaw));
                selectionController.enable = false;
              }
            },
    );
  }

  _startRefresh() {
    if (_refreshCompleter?.isCompleted == false) _refreshCompleter?.complete();
    _refreshCompleter = Completer();
    _refreshKey.currentState.show();
  }

  bool isBackgroundRefresh = false;

  onAlarm() {
    isBackgroundRefresh = true;
    _startRefresh();
  }

  onEndAlarm(bool hasUpdate) {
    if (_refreshCompleter?.isCompleted == false) _refreshCompleter?.complete();
  }
}
