part of 'coin_bloc.dart';

sealed class CoinEvent extends Equatable {
  const CoinEvent();

  @override
  List<Object> get props => [];
}

class CreateACoin extends CoinEvent {
  final String symbol;
  final String price;

  const CreateACoin({required this.symbol, required this.price});
}
