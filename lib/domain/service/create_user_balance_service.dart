import 'package:crypto_portfolio_test/core/errors/failures.dart';
import 'package:crypto_portfolio_test/domain/entities/balance.dart';
import 'package:crypto_portfolio_test/domain/repositories/balance_repository.dart';
import 'package:crypto_portfolio_test/domain/service/service.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class CreateUserBalanceService implements Service<Balance, Params> {
  final BalanceRepository repository;

  CreateUserBalanceService(this.repository);

  @override
  Future<Either<Failure, Balance>> call(Params params) async {
    return await repository.createOrUpdateUserBalance(
        params.symbol, params.balance, params.walletAddress);
  }
}

class Params extends Equatable {
  final String symbol;
  final double balance;
  final String walletAddress;

  const Params(
      {required this.symbol,
      required this.balance,
      required this.walletAddress});

  @override
  List<Object> get props => [symbol, balance, walletAddress];
}
