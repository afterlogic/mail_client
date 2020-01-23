import 'package:aurora_mail/database/app_database.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class InitialAuthState extends AuthState {}

class InitializedUserAndAccounts extends AuthState {
  final List<User> users;
  final User user;
  final bool needsLogin;

  const InitializedUserAndAccounts({
    @required this.user,
    @required this.users,
    @required this.needsLogin,
  })
      : assert(needsLogin != null);

  @override
  List<Object> get props => [user, needsLogin];
}

class ReceivedLastEmail extends AuthState {
  final String email;

  const ReceivedLastEmail(this.email);

  @override
  List<Object> get props => [email];
}

class LoggingIn extends AuthState {}

class NeedsHost extends AuthState {}

class LoggedIn extends AuthState {
  final User user;
  final List<User> users;

  const LoggedIn(this.user, this.users);

  @override
  List<Object> get props => [user];
}

class LoggedOut extends AuthState {}

class AuthError extends AuthState {
  final String errorMsg;

  const AuthError(this.errorMsg);

  @override
  List<Object> get props => [errorMsg];
}
