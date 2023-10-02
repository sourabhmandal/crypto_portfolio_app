import 'package:crypto_portfolio_test/core/errors/exceptions.dart';
import 'package:crypto_portfolio_test/core/errors/failures.dart';
import 'package:crypto_portfolio_test/core/network/network_info.dart';
import 'package:crypto_portfolio_test/data/datasources/balance_remote_data_source.dart';
import 'package:crypto_portfolio_test/domain/entities/balance.dart';
import 'package:crypto_portfolio_test/domain/repositories/balance_repository.dart';
import 'package:dartz/dartz.dart';

class BalanceRepositoryImpl implements BalanceRepository {
  late final BalanceRemoteDataSource remoteDataSource;
  late final NetworkInfo networkInfo;

  BalanceRepositoryImpl(
      {required this.remoteDataSource, required this.networkInfo});

  @override
  Future<Either<Failure, List<Balance>>> getAllUserBalances(
      String walletAddress) async {
    if (await networkInfo.isConnected) {
      try {
        final List<Balance> remoteBalances =
            await remoteDataSource.getAllUserBalances(walletAddress);
        return Right(remoteBalances);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, Balance>> createOrUpdateUserBalance(
      String symbol, double balance, String walletAddress) async {
    if (await networkInfo.isConnected) {
      try {
        final Balance savedBalance = await remoteDataSource
            .createOrUpdateUserBalance(symbol, balance, walletAddress);
        return Right(savedBalance);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, Balance>> getSwapTransactionData(
      String symbol, double balance, String walletAddress) {
    // TODO: implement getSwapTransactionData
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Balance>> makeSwapTransactionData(
      String sendCoinSymbol,
      double sendCoinPrice,
      String getCoinSymbol,
      double getCoinPrice,
      String walletAddress) {
    // TODO: implement makeSwapTransactionData
    throw UnimplementedError();
  }
}
