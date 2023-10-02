import 'package:crypto_portfolio_test/data/apidef/create_or_update_coin_api.dart';
import 'package:crypto_portfolio_test/data/apidef/get_all_coins_api.dart';
import 'package:crypto_portfolio_test/data/models/coin.dart';
import 'package:crypto_portfolio_test/domain/entities/coins.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

abstract class CoinRemoteDataSource {
  Future<List<Coin>> getAllCoins();
  Future<Coin> createOrUpdateCoin(String symbol, double price);
}

class CoinRemoteDataSourceImpl implements CoinRemoteDataSource {
  final GraphQLClient graphQLClient;
  CoinRemoteDataSourceImpl({
    required this.graphQLClient,
  });

  @override
  Future<Coin> createOrUpdateCoin(String symbol, double price) async {
    try {
      QueryResult result = await graphQLClient.mutate(MutationOptions(
        fetchPolicy: FetchPolicy.noCache,
        document: createOrUpdateCoinApiDocument(),
        variables: {'symbol': symbol, 'price': '$price'},
      ));

      print(result);

      if (result.hasException) {
        print(result.exception);
        throw const ServerException();
      }

      final resData = result.data?['upsertCoin'];

      print(resData);

      if (resData == null) {
        throw const ServerException();
      }
      print(resData);

      return CoinModel.fromGraphql(map: resData);
    } on ServerException {
      throw const ServerException();
    }
  }

  @override
  Future<List<Coin>> getAllCoins() async {
    try {
      QueryResult result = await graphQLClient.query(QueryOptions(
          fetchPolicy: FetchPolicy.noCache,
          document: getAllCoinsApiDocument()));

      print(result);

      if (result.hasException) {
        print(result.exception);
        throw const ServerException();
      }

      List? resData = [];
      resData = result.data?['getAllCoins'];

      print(resData);

      if (resData == null) {
        throw const ServerException();
      }

      print(resData);

      List<Coin> coins =
          resData.map((e) => CoinModel.fromGraphql(map: e)).toList();
      return coins;
    } on ServerException {
      throw const ServerException();
    }
  }
}
