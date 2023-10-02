import 'package:crypto_portfolio_test/domain/entities/swap.dart';
import 'package:crypto_portfolio_test/domain/service/get_swap_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'get_swap_balance_event.dart';
part 'get_swap_balance_state.dart';

class GetSwapBalanceBloc
    extends Bloc<GetSwapBalanceEvent, GetSwapBalanceState> {
  final GetSwapService getSwapService;

  GetSwapBalanceBloc({required this.getSwapService}) : super(Empty()) {
    on<SwapBalances>((event, emit) async {
      print("EVENT : SwapBalances triggered");
      emit(Loading());
      final createdBalance =
          await getSwapService.call(Params(walletAddress: event.walletAddress));
      createdBalance.fold((l) async => emit(Error(message: l.toString())),
          (r) async {
        return emit(Loaded(swapBalance: r));
      });
    });
  }
}
