part of 'auth_bloc.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<AuthUser> get props => [];
}


class Empty extends AuthState {
  @override
  List<AuthUser> get props => [];
}

class Loading extends AuthState {
  @override
  List<AuthUser> get props => [];
}

class LoggedIn extends AuthState {
  final AuthUser authUser;

  const LoggedIn({required this.authUser});

  @override
  List<AuthUser> get props => [authUser];
}

class LoggedOut extends AuthState {
  final bool isLoggedIn;
  const LoggedOut({required this.isLoggedIn});

  @override
  List<AuthUser> get props => [];
}

class Error extends AuthState {
  final String message;

  const Error({required this.message});

  @override
  List<AuthUser> get props => [];
}