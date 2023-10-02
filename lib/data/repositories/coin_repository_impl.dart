import 'package:crypto_portfolio_test/core/errors/exceptions.dart';
import 'package:crypto_portfolio_test/core/errors/failures.dart';
import 'package:crypto_portfolio_test/core/network/network_info.dart';
import 'package:crypto_portfolio_test/data/datasources/coin_local_data_source.dart';
import 'package:crypto_portfolio_test/data/datasources/coin_remote_data_source.dart';
import 'package:crypto_portfolio_test/data/models/coin.dart';
import 'package:crypto_portfolio_test/domain/entities/coins.dart';
import 'package:crypto_portfolio_test/domain/repositories/coin_repository.dart';
import 'package:dartz/dartz.dart';

class CoinRepositoryImpl implements CoinRepository {
  late final CoinRemoteDataSource remoteDataSource;
  late final CoinLocalDataSource localDataSource;
  late final NetworkInfo networkInfo;

  CoinRepositoryImpl(
      {required this.remoteDataSource,
      required this.localDataSource,
      required this.networkInfo});

  @override
  Future<Either<Failure, List<Coin>>> getAllCoins() async {
    if (await networkInfo.isConnected) {
      try {
        final List<Coin> remoteCoins = await remoteDataSource.getAllCoins();
        final List<CoinModel> cacheRemoteData = remoteCoins
            .map((e) => CoinModel(symbol: e.symbol, price: e.price))
            .toList();
        localDataSource.cacheAllCoin(cacheRemoteData);
        return Right(remoteCoins);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final List<Coin> localCoins = await localDataSource.getLastAllCoin();
        return Right(localCoins);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, Coin>> createCoin(String symbol, double price) async {
    if (await networkInfo.isConnected) {
      try {
        final Coin savedCoin =
            await remoteDataSource.createOrUpdateCoin(symbol, price);
        return Right(savedCoin);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }
}
