part of 'get_all_user_balances_bloc.dart';

sealed class GetAllUserBalanceState extends Equatable {
  const GetAllUserBalanceState();

  @override
  List<Object> get props => [];
}

class Empty extends GetAllUserBalanceState {
  @override
  List<Balance> get props => [];
}

class Loading extends GetAllUserBalanceState {
  @override
  List<Balance> get props => [];
}

class Loaded extends GetAllUserBalanceState {
  final List<Balance> balanceList;

  const Loaded({required this.balanceList});

  @override
  List<Balance> get props => balanceList;
}

class Error extends GetAllUserBalanceState {
  final String message;

  const Error({required this.message});

  @override
  List<Balance> get props => [];
}
