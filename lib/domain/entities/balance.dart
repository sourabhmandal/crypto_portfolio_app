import 'package:equatable/equatable.dart';

class Balance extends Equatable {
  final String symbol;
  final double balance;
  final String walletAddress;
  final double value;

  const Balance(
      {required this.symbol,
      required this.balance,
      required this.walletAddress,
      required this.value});

  @override
  List<Object> get props => [symbol, balance, walletAddress];
}
