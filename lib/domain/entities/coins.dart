import 'package:equatable/equatable.dart';

class Coin extends Equatable {
  final String symbol;
  final double price;
  String change;

  Coin({required this.symbol, required this.price, required this.change});

  @override
  List<Object> get props => [symbol, price];
}
