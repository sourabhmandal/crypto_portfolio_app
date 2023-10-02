part of 'make_swap_balance_bloc.dart';

sealed class MakeSwapBalanceState extends Equatable {
  const MakeSwapBalanceState();

  @override
  List<Object> get props => [];
}

class Empty extends MakeSwapBalanceState {
  @override
  List<bool> get props => [];
}

class Loading extends MakeSwapBalanceState {
  @override
  List<bool> get props => [];
}

class Loaded extends MakeSwapBalanceState {
  final bool isSwapped;

  const Loaded({required this.isSwapped});

  @override
  List<bool> get props => [isSwapped];
}

class Error extends MakeSwapBalanceState {
  final String message;

  const Error({required this.message});

  @override
  List<bool> get props => [];
}
