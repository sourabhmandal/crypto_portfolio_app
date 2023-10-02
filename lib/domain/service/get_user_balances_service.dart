import 'package:crypto_portfolio_test/core/errors/failures.dart';
import 'package:crypto_portfolio_test/domain/entities/balance.dart';
import 'package:crypto_portfolio_test/domain/repositories/balance_repository.dart';
import 'package:crypto_portfolio_test/domain/service/service.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class GetUserBalanceService implements Service<List<Balance>, Params> {
  final BalanceRepository repository;

  GetUserBalanceService(this.repository);

  @override
  Future<Either<Failure, List<Balance>>> call(Params params) async {
    return await repository.getAllUserBalances(params.walletAddress);
  }
}

class Params extends Equatable {
  final String walletAddress;

  const Params({required this.walletAddress});

  @override
  List<Object> get props => [walletAddress];
}
