import 'dart:async';

import 'package:alarm_service/alarm_service.dart';
import 'package:aurora_mail/config.dart';
import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/models/alias_or_identity.dart';
import 'package:aurora_mail/modules/auth/blocs/auth_bloc/auth_methods.dart';
import 'package:aurora_mail/modules/auth/repository/auth_api.dart';
import 'package:aurora_mail/res/str/s.dart';
import 'package:aurora_mail/utils/api_utils.dart';
import 'package:aurora_mail/utils/error_to_show.dart';
import 'package:bloc/bloc.dart';

import './bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final _methods = new AuthMethods();

  Account currentAccount;
  List<User> users = [];

//  static String hostName;
  List<Account> accounts = [];
  AccountIdentity currentIdentity;
  User currentUser;

  @override
  AuthState get initialState => InitialAuthState();

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    if (event is InitUserAndAccounts) yield* _initUserAndAccounts(event);
    if (event is GetLastEmail) yield* _getLastEmail(event);
    if (event is LogIn) yield* _login(event);
    if (event is SelectUser) yield* _selectUser(event);
    if (event is SelectUserByEmail) yield* _selectUserByEmail(event);
    if (event is DeleteUser) yield* _deleteUser(event);
    if (event is InvalidateCurrentUserToken)
      yield* _invalidateCurrentUserToken(event);
    if (event is ChangeAccount) yield* _changeAccount(event);
    if (event is UserLogIn) yield* _userLogIn(event);
    if (event is UpdateAccounts) yield* _updateAccounts(event);
  }

  Stream<AuthState> _initUserAndAccounts(InitUserAndAccounts event) async* {
    final result = await _methods.getUserAndAccountsFromDB();
    users = await _methods.users;

    try {
      if (result != null) {
        accounts = result.accounts;
        currentUser = result.user;
        currentAccount = result.account;

        final identities =
            await _methods.getAccountIdentities(currentUser, currentAccount);
        _methods.setFbToken(users);
        currentIdentity = identities.firstWhere((item) => item.isDefault,
                orElse: () => null) ??
            AccountIdentity(
              email: currentAccount.email,
              useSignature: currentAccount.useSignature,
              idUser: currentAccount.idUser,
              isDefault: true,
              idAccount: currentAccount.accountId,
              friendlyName: currentAccount.friendlyName,
              signature: currentAccount.signature,
              entityId: currentAccount.serverId,
            );

        yield InitializedUserAndAccounts(
          user: currentUser,
          users: users,
          needsLogin: false,
          account: currentAccount,
          accounts: result.accounts,
          identity: currentIdentity,
        );
      } else {
        yield InitializedUserAndAccounts(
          user: null,
          users: null,
          needsLogin: true,
          account: null,
          accounts: null,
        );
      }
    } catch (err, s) {
      print("_initUserAndAccounts err: $err");
      print("_initUserAndAccounts s: $s");
      yield InitializedUserAndAccounts(
        user: null,
        users: null,
        needsLogin: true,
        account: null,
        accounts: null,
      );
    }
    event.completer?.complete();
  }

  Stream<AuthState> _getLastEmail(GetLastEmail event) async* {
    final email = await _methods.lastEmail;
    if (email != null) yield ReceivedLastEmail(email);
  }

  Stream<AuthState> _selectUserByEmail(SelectUserByEmail event) async* {
    if (currentUser.emailFromLogin == event.email) {
      event.completer?.complete();
      return;
    }
    await _methods.selectUserByEmail(event.email);
    yield UserSelected();
    add(InitUserAndAccounts(event.completer));
  }

  Stream<AuthState> _selectUser(SelectUser event) async* {
    if (currentUser.localId == event.userLocalId &&
        (event.accountLocalId == null ||
            currentAccount.localId == event.accountLocalId)) {
      event.completer?.complete();
      return;
    }
    await _methods.selectUser(event.userLocalId);
    if (event.accountLocalId != null) {
      await _methods.selectAccount(event.accountLocalId);
    }
    yield UserSelected();
    add(InitUserAndAccounts(event.completer));
  }

  Stream<AuthState> _login(LogIn event) async* {
    yield LoggingIn();
    users = await _methods.users;
    final userFromDb = users.firstWhere((u) => u.emailFromLogin == event.email,
        orElse: () => null);

    if (!event.firstLogin && userFromDb != null) {
      yield AuthError(ErrorToShow.code(S.error_user_already_logged));
      return;
    } else {
      try {
        var user = await _methods.login(
          email: event.email,
          password: event.password,
          host: event.hostname,
        );
        if (userFromDb != null) {
          user = user.copyWith(localId: userFromDb.localId);
        }

        if (user == null) {
          yield NeedsHost();
        } else {
          yield* _userLogIn(UserLogIn(user));
        }
      } catch (err, s) {
        if (err is RequestTwoFactor) {
          yield TwoFactor(
            event.email,
            event.password,
            err.host,
          );
        } else if (err is AllowAccess) {
          yield UpgradePlan(null);
        } else {
          yield AuthError(formatError(err, s));
        }
      }
    }
  }

  Stream<AuthState> _userLogIn(UserLogIn event) async* {
    try {
      final user = await _methods.setUser(event.user);
      users = await _methods.users;
      currentUser = user;
      final accounts = await _methods.getAccounts(user);
      _methods.setFbToken(users);
      if (accounts.isNotEmpty) {
        assert(accounts[0] != null);
        this.accounts = accounts;
        currentAccount = accounts[0];
        await _methods.updateAliases(currentUser, currentAccount);
        final identities = await _methods.updateIdentity(
          currentUser,
          currentAccount,
          accounts,
        );
        currentIdentity =
            _methods.getDefaultIdentity(currentAccount, identities);
        yield InitializedUserAndAccounts(
          users: users,
          user: currentUser,
          accounts: accounts,
          account: currentAccount,
          needsLogin: false,
        );
      } else {
        yield AuthError(ErrorToShow.code(S.error_login_no_accounts));
      }
    } catch (e, s) {
      yield AuthError(formatError(e, s));
    }
  }

  Stream<AuthState> _updateAccounts(UpdateAccounts event) async* {
    if (currentUser == null) {
      return;
    }
    await _methods.getAccounts(currentUser).then((accounts) async {
      assert(accounts.isNotEmpty);
      if (currentAccount == null ||
          accounts.firstWhere(
                  (element) => element.serverId == currentAccount.serverId,
                  orElse: () => null) ==
              null) {
        currentAccount = accounts[0];
      }
      this.accounts = accounts;
      await _methods.updateAliases(currentUser, currentAccount);
      final identities = await _methods.updateIdentity(
        currentUser,
        currentAccount,
        accounts,
      );
      if (currentIdentity == null ||
          identities.firstWhere(
                  (element) => element.entityId == currentIdentity.entityId,
                  orElse: () => null) ==
              null) {
        currentIdentity =
            _methods.getDefaultIdentity(currentAccount, identities);
      }
      add(InitUserAndAccounts());
    }).whenComplete(() => event.completer?.complete());
  }

  Stream<AuthState> _deleteUser(DeleteUser event) async* {
    await AlarmService.removeAlarm(ALARM_ID);
    try {
      if (users.length == 1) {
       await _methods.setFbToken(users,true);
      }
      await _methods.logout(currentUser.localId, event.user);
      users = await _methods.users;
      if (users.isNotEmpty) {
        if (currentUser.localId != event.user.localId) {
          add(InitUserAndAccounts());
        } else {
          add(SelectUser(users[0].localId));
        }
        _methods.setFbToken(users);
      } else {
        yield LoggedOut();
      }
    } catch (err, s) {
      yield AuthError(formatError(err, s));
    }
  }

  Stream<AuthState> _invalidateCurrentUserToken(
      InvalidateCurrentUserToken event) async* {
    if (currentUser != null) {
      currentUser = await _methods.invalidateToken(currentUser.localId);
      add(InitUserAndAccounts());
    } else {
      print("cannot invalidate token, no currentUser selected");
    }
  }

  Stream<AuthState> _changeAccount(ChangeAccount event) async* {
    await _methods.selectAccount(event.account.localId);
    add(InitUserAndAccounts());
  }

  Future<List<AccountIdentity>> getIdentities([bool forAllAccount]) {
    return _methods.getAccountIdentities(
      currentUser,
      forAllAccount == true ? null : currentAccount,
    );
  }

  Future<List<Aliases>> getAliases([bool forAllAccount]) {
    return _methods.getAccountAliases(
      currentUser,
      forAllAccount == true ? null : currentAccount,
    );
  }

  Future<List<AliasOrIdentity>> getAliasesAndIdentities(
      [bool forAllAccount]) async {
    final identities = await getIdentities(forAllAccount);
    final aliases = await getAliases(forAllAccount);
    final items = <AliasOrIdentity>[];
    for (var value in identities) {
      items.add(AliasOrIdentity(null, value));
    }
    for (var value in aliases) {
      items.add(AliasOrIdentity(value, null));
    }
    return items;
  }
}
