import 'package:crypto_portfolio_test/domain/entities/auth_user.dart';
import 'package:crypto_portfolio_test/domain/entities/coins.dart';
import 'package:crypto_portfolio_test/domain/service/login_user_service.dart';
import 'package:crypto_portfolio_test/domain/service/logout_user_service.dart';
import 'package:crypto_portfolio_test/domain/service/service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {

  final LoginUserService loginUserService;
  final LogoutUserService logoutUserService;

  AuthBloc({
    required this.loginUserService,
    required this.logoutUserService}) : super(Empty()) {
    on<LoginUser>((event, emit) async {
      emit(Loading());
      final authUser = await loginUserService.call(NoParams());
      authUser.fold(
        (l) => emit(Error(message: l.toString())),
        (r) => emit(LoggedIn(authUser: r))
      );
    });
    on<LogoutUser>((event, emit) async {
      emit(Loading());
      final authUser = await logoutUserService.call(NoParams());
      authUser.fold(
              (l) => emit(Error(message: l.toString())),
              (r) => emit(LoggedOut(isLoggedIn: r))
      );
    });
  }
}
