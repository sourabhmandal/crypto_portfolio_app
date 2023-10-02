part of 'get_swap_balance_bloc.dart';

sealed class GetSwapBalanceEvent extends Equatable {
  const GetSwapBalanceEvent();

  @override
  List<Object> get props => [];
}

class SwapBalances extends GetSwapBalanceEvent {
  final String walletAddress;

  const SwapBalances({required this.walletAddress});
}
