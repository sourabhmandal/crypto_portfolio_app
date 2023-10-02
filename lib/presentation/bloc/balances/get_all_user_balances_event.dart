part of 'get_all_user_balances_bloc.dart';

sealed class GetAllUserBalanceEvent extends Equatable {
  const GetAllUserBalanceEvent();

  @override
  List<Object> get props => [];
}

class LoadAllUserBalances extends GetAllUserBalanceEvent {
  final String walletAddress;

  const LoadAllUserBalances({required this.walletAddress});
}
