import 'package:crypto_portfolio_test/domain/entities/coins.dart';
import 'package:crypto_portfolio_test/domain/repositories/coin_repository.dart';
import 'package:crypto_portfolio_test/domain/service/service.dart';
import 'package:crypto_portfolio_test/core/errors/failures.dart';
import 'package:dartz/dartz.dart';

class GetAllCoinsService implements Service<List<Coin>, NoParams> {
  final CoinRepository repository;

  GetAllCoinsService(this.repository);

  @override
  Future<Either<Failure, List<Coin>>> call(NoParams params) async {
    return await repository.getAllCoins();
  }
}