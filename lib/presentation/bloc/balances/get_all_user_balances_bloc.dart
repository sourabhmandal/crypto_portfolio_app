import 'package:crypto_portfolio_test/domain/entities/balance.dart';
import 'package:crypto_portfolio_test/domain/service/get_user_balances_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'get_all_user_balances_event.dart';
part 'get_all_user_balances_state.dart';

class GetUserBalanceBloc
    extends Bloc<GetAllUserBalanceEvent, GetAllUserBalanceState> {
  final GetUserBalanceService getUserBalanceService;

  GetUserBalanceBloc({required this.getUserBalanceService}) : super(Empty()) {
    on<LoadAllUserBalances>((event, emit) async {
      emit(Loading());
      final balanceList = await getUserBalanceService
          .call(Params(walletAddress: event.walletAddress));
      balanceList.fold((l) async => emit(Error(message: l.toString())),
          (r) async {
        if (r.isEmpty) {
          return emit(Empty());
        }

        return emit(Loaded(balanceList: r));
      });
    });
  }
}
