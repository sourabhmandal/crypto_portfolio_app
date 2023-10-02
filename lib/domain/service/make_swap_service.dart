import 'package:crypto_portfolio_test/core/errors/failures.dart';
import 'package:crypto_portfolio_test/domain/entities/balance.dart';
import 'package:crypto_portfolio_test/domain/entities/coins.dart';
import 'package:crypto_portfolio_test/domain/repositories/balance_repository.dart';
import 'package:crypto_portfolio_test/domain/service/service.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../repositories/coin_repository.dart';

class MakeSwapService implements Service<bool, Params> {
  final BalanceRepository balanceRepository;
  final CoinRepository coinRepository;

  MakeSwapService(
      {required this.balanceRepository, required this.coinRepository});

  @override
  Future<Either<Failure, bool>> call(Params params) async {
    final userBalancesOrFail =
        await balanceRepository.getAllUserBalances(params.walletAddress);

    final userBalance = userBalancesOrFail.fold((l) => Left(l), (r) => r);

    final allCoinsOrFail = await coinRepository.getAllCoins();
    final allCoins = allCoinsOrFail.fold((l) => Left(l), (r) => r);

    // calculate get-coins value
    if (userBalance is List<Balance> && allCoins is List<Coin>) {
      print(
          "${params.sendCoinPrice} * ${params.sendCoinAmount} / ${params.getCoinPrice}");
      double getCoinAmount =
          (params.sendCoinPrice * params.sendCoinAmount) / params.getCoinPrice;

      print(
          "GET_COIN_SYMBOL: ${params.getCoinSymbol}, GET AMOUNT: $getCoinAmount, GET WALLET:  ${params.walletAddress}");
      // deposit get coins
      await balanceRepository.createOrUpdateUserBalance(
          params.getCoinSymbol, getCoinAmount, params.walletAddress);
      print(
          "GET_COIN_SYMBOL: ${params.sendCoinSymbol}, GET AMOUNT: 11, GET WALLET:  ${params.walletAddress}");

      // deduct send coins
      await balanceRepository.createOrUpdateUserBalance(
          params.sendCoinSymbol, 0, params.walletAddress);

      return const Right(true);
    }
    return Left(ServerFailure());
  }
}

class Params extends Equatable {
  final String sendCoinSymbol;
  final double sendCoinPrice;
  final double sendCoinAmount;
  final String getCoinSymbol;
  final double getCoinPrice;
  final String walletAddress;

  const Params(
      {required this.sendCoinSymbol,
      required this.sendCoinPrice,
      required this.getCoinSymbol,
      required this.getCoinPrice,
      required this.walletAddress,
      required this.sendCoinAmount});

  @override
  List<Object> get props => [
        sendCoinSymbol,
        sendCoinPrice,
        getCoinSymbol,
        getCoinPrice,
        walletAddress
      ];
}
