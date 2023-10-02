part of 'all_coins_bloc.dart';

sealed class AllCoinState extends Equatable {
  const AllCoinState();

  @override
  List<Object> get props => [];

  get coinList => null;
}

class Empty extends AllCoinState {
  @override
  List<Coin> get props => [];
}

class Loading extends AllCoinState {
  @override
  List<Coin> get props => [];
}

class Loaded extends AllCoinState {
  final List<Coin> coinList;

  const Loaded({required this.coinList});

  @override
  List<Coin> get props => coinList;
}

class Error extends AllCoinState {
  final String message;

  const Error({required this.message});

  @override
  List<Coin> get props => [];
}
