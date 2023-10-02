import 'package:crypto_portfolio_test/domain/entities/balance.dart';
import 'package:crypto_portfolio_test/domain/service/create_user_balance_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'create_user_balance_event.dart';
part 'create_user_balance_state.dart';

class CreateUserBalanceBloc
    extends Bloc<CreateUserBalanceEvent, CreateUserBalanceState> {
  final CreateUserBalanceService createUserBalanceService;

  CreateUserBalanceBloc({required this.createUserBalanceService})
      : super(Empty()) {
    on<CreateUserBalance>((event, emit) async {
      emit(Loading());
      final createdBalance = await createUserBalanceService.call(Params(
          balance: event.balance,
          walletAddress: event.walletAddress,
          symbol: event.symbol));
      createdBalance.fold((l) async => emit(Error(message: l.toString())),
          (r) async {
        return emit(Loaded(createdBalance: r));
      });
    });
  }
}
