import 'package:crypto_portfolio_test/core/errors/failures.dart';
import 'package:crypto_portfolio_test/domain/entities/balance.dart';
import 'package:dartz/dartz.dart';

abstract class BalanceRepository {
  Future<Either<Failure, List<Balance>>> getAllUserBalances(
      String walletAddress);
  Future<Either<Failure, Balance>> createOrUpdateUserBalance(
      String symbol, double balance, String walletAddress);
}
