import 'package:equatable/equatable.dart';

class Swap extends Equatable {
  final String username;
  final List<SwapBalance> balances;
  final String walletAddress;

  const Swap(
      {required this.username,
      required this.balances,
      required this.walletAddress});

  @override
  List<Object> get props => [username, balances, walletAddress];
}

class SwapBalance extends Equatable {
  final double coinPriceInDollar;
  final double balance;
  final double value;
  final String symbol;

  const SwapBalance(
      {required this.coinPriceInDollar,
      required this.balance,
      required this.value,
      required this.symbol});

  @override
  List<Object> get props => [symbol, balance, coinPriceInDollar];
}
