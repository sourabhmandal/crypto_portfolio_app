part of 'create_user_balance_bloc.dart';

sealed class CreateUserBalanceEvent extends Equatable {
  const CreateUserBalanceEvent();

  @override
  List<Object> get props => [];
}

class CreateUserBalance extends CreateUserBalanceEvent {
  final String walletAddress;
  final double balance;
  final String symbol;

  const CreateUserBalance(
      {required this.walletAddress,
      required this.balance,
      required this.symbol});
}
