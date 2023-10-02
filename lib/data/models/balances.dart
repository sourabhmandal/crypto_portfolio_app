import 'package:crypto_portfolio_test/domain/entities/balance.dart';

class BalanceModel extends Balance {
  const BalanceModel(
      {required String symbol,
      required double balance,
      required String walletAddress,
      required double value})
      : super(
            symbol: symbol,
            balance: balance,
            walletAddress: walletAddress,
            value: value);

  static BalanceModel fromGraphql({required Map<String, dynamic> map}) =>
      BalanceModel(
          symbol: map['symbol'],
          balance: double.parse(
              (map['balance'] as num).toDouble().toStringAsFixed(2)),
          value: double.parse(double.parse(map['value']).toStringAsFixed(2)),
          walletAddress: map['walletAddress']);
}
