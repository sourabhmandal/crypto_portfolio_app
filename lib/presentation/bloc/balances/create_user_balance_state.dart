part of 'create_user_balance_bloc.dart';

sealed class CreateUserBalanceState extends Equatable {
  const CreateUserBalanceState();

  @override
  List<Object> get props => [];
}

class Empty extends CreateUserBalanceState {
  @override
  List<Balance> get props => [];
}

class Loading extends CreateUserBalanceState {
  @override
  List<Balance> get props => [];
}

class Loaded extends CreateUserBalanceState {
  final Balance createdBalance;

  const Loaded({required this.createdBalance});

  @override
  List<Balance> get props => [createdBalance];
}

class Error extends CreateUserBalanceState {
  final String message;

  const Error({required this.message});

  @override
  List<Balance> get props => [];
}
