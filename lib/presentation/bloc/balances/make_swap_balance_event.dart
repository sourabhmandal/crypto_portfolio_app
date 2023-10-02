part of 'make_swap_balance_bloc.dart';

sealed class MakeSwapBalanceEvent extends Equatable {
  const MakeSwapBalanceEvent();

  @override
  List<Object> get props => [];
}

class SwapBalances extends MakeSwapBalanceEvent {
  final String sendCoinSymbol;
  final double sendCoinPrice;
  final double sendCoinAmount;
  final String getCoinSymbol;
  final double getCoinPrice;
  final String walletAddress;

  const SwapBalances({
    required this.walletAddress,
    required this.sendCoinSymbol,
    required this.sendCoinPrice,
    required this.getCoinSymbol,
    required this.sendCoinAmount,
    required this.getCoinPrice,
  });
}
