part of 'get_swap_balance_bloc.dart';

sealed class GetSwapBalanceState extends Equatable {
  const GetSwapBalanceState();

  @override
  List<Object> get props => [];
}

class Empty extends GetSwapBalanceState {
  @override
  List<Swap> get props => [];
}

class Loading extends GetSwapBalanceState {
  @override
  List<Swap> get props => [];
}

class Loaded extends GetSwapBalanceState {
  final Swap swapBalance;

  const Loaded({required this.swapBalance});

  @override
  List<Swap> get props => [swapBalance];
}

class Error extends GetSwapBalanceState {
  final String message;

  const Error({required this.message});

  @override
  List<Swap> get props => [];
}
