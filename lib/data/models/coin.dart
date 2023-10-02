import 'package:crypto_portfolio_test/domain/entities/coins.dart';

class CoinModel extends Coin {
  CoinModel({required String symbol, required double price})
      : super(symbol: symbol, price: price, change: '');

  static CoinModel fromGraphql({required Map<String, dynamic> map}) =>
      CoinModel(symbol: map['symbol'], price: (map['price'] as num).toDouble());

  factory CoinModel.fromJSON(Map<String, dynamic> json) {
    return CoinModel(
        symbol: json['symbol'], price: (json['price'] as num).toDouble());
  }

  Map<String, dynamic> toJSON() {
    return {
      'symbol': symbol,
      'price': price,
    };
  }
}
