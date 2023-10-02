
import 'package:crypto_portfolio_test/domain/entities/coins.dart';
import 'package:crypto_portfolio_test/domain/repositories/coin_repository.dart';
import 'package:crypto_portfolio_test/domain/service/service.dart';
import 'package:crypto_portfolio_test/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class CreateCoinService implements Service<Coin, Params>{
  final CoinRepository repository;

  CreateCoinService(this.repository);

  @override
  Future<Either<Failure, Coin>> call(Params params) async {
    return await repository.createCoin(params.symbol, params.price);
  }
}


class Params extends Equatable {
  final String symbol;
  final double price;

  const Params({required this.symbol, required this.price});

  @override
  List<Object> get props => [symbol, price];
}