part of 'coin_bloc.dart';

sealed class CoinState extends Equatable {
  const CoinState();

  @override
  List<Coin> get props => [];
}

class Empty extends CoinState {
  @override
  List<Coin> get props => [];
}

class Loading extends CoinState {
  @override
  List<Coin> get props => [];
}

class Loaded extends CoinState {
  final Coin createdCoin;

  const Loaded({required this.createdCoin});

  @override
  List<Coin> get props => [createdCoin];
}

class Error extends CoinState {
  final String message;

  const Error({required this.message});

  @override
  List<Coin> get props => [];
}
