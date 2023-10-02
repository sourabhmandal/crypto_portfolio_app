import 'package:crypto_portfolio_test/domain/entities/coins.dart';
import 'package:crypto_portfolio_test/core/errors/failures.dart';
import 'package:dartz/dartz.dart';

abstract class CoinRepository {
  Future<Either<Failure, List<Coin>>> getAllCoins();
  Future<Either<Failure, Coin>> createCoin(String symbol, double price);
}