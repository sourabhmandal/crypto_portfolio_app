import 'package:crypto_portfolio_test/domain/service/make_swap_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'make_swap_balance_event.dart';
part 'make_swap_balance_state.dart';

class MakeSwapBalanceBloc
    extends Bloc<MakeSwapBalanceEvent, MakeSwapBalanceState> {
  final MakeSwapService makeSwapService;

  MakeSwapBalanceBloc({required this.makeSwapService}) : super(Empty()) {
    on<SwapBalances>((event, emit) async {
      emit(Loading());
      final createdBalance = await makeSwapService.call(Params(
          walletAddress: event.walletAddress,
          getCoinPrice: event.getCoinPrice,
          getCoinSymbol: event.getCoinSymbol,
          sendCoinAmount: event.sendCoinAmount,
          sendCoinPrice: event.sendCoinPrice,
          sendCoinSymbol: event.sendCoinSymbol));
      createdBalance.fold((l) async => emit(Error(message: l.toString())),
          (r) async {
        return emit(Loaded(isSwapped: r));
      });
    });
  }
}
