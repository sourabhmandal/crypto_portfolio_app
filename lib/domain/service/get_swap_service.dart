import 'package:crypto_portfolio_test/core/errors/failures.dart';
import 'package:crypto_portfolio_test/domain/entities/balance.dart';
import 'package:crypto_portfolio_test/domain/entities/coins.dart';
import 'package:crypto_portfolio_test/domain/entities/swap.dart';
import 'package:crypto_portfolio_test/domain/repositories/balance_repository.dart';
import 'package:crypto_portfolio_test/domain/service/service.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../repositories/coin_repository.dart';

class GetSwapService implements Service<Swap, Params> {
  final BalanceRepository balanceRepository;
  final CoinRepository coinRepository;

  GetSwapService(
      {required this.balanceRepository, required this.coinRepository});

  @override
  Future<Either<Failure, Swap>> call(Params params) async {
    final userBalancesOrFail =
        await balanceRepository.getAllUserBalances(params.walletAddress);

    final userBalance = userBalancesOrFail.fold((l) => Left(l), (r) => r);

    final allCoinsOrFail = await coinRepository.getAllCoins();
    final allCoins = allCoinsOrFail.fold((l) => Left(l), (r) => r);

    if (userBalance is List<Balance> && allCoins is List<Coin>) {
      List<SwapBalance> balances = userBalance.map((_balance) {
        final coinData =
            allCoins.firstWhere((_coin) => _coin.symbol == _balance.symbol);
        final SwapBalance balanceData = SwapBalance(
            coinPriceInDollar: coinData.price,
            balance: _balance.balance,
            symbol: _balance.symbol,
            value: _balance.value);
        return balanceData;
      }).toList();

      return Right(Swap(
          username: 'john',
          balances: balances,
          walletAddress: params.walletAddress));
    }
    return Left(ServerFailure());
  }
}

class Params extends Equatable {
  final String walletAddress;

  const Params({required this.walletAddress});

  @override
  List<Object> get props => [walletAddress];
}
