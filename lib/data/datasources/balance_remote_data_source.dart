import 'package:crypto_portfolio_test/data/apidef/create_user_balances_api.dart';
import 'package:crypto_portfolio_test/data/apidef/get_user_balances_api.dart';
import 'package:crypto_portfolio_test/data/models/balances.dart';
import 'package:crypto_portfolio_test/domain/entities/balance.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

abstract class BalanceRemoteDataSource {
  Future<List<Balance>> getAllUserBalances(String walletAddress);
  Future<Balance> createOrUpdateUserBalance(
      String symbol, double balance, String walletAddress);
}

class BalanceRemoteDataSourceImpl implements BalanceRemoteDataSource {
  final GraphQLClient graphQLClient;
  BalanceRemoteDataSourceImpl({
    required this.graphQLClient,
  });

  @override
  Future<Balance> createOrUpdateUserBalance(
      String symbol, double balance, String walletAddress) async {
    print(walletAddress);
    try {
      QueryResult result = await graphQLClient.mutate(MutationOptions(
        fetchPolicy: FetchPolicy.noCache,
        document: createUserBalanceDocument(),
        variables: {
          'symbol': symbol,
          'balance': '$balance',
          'walletAddress': walletAddress
        },
      ));

      print(result);

      if (result.hasException) {
        print(result.exception);
        throw const ServerException();
      }

      final resData = result.data?['upsertBalance'];

      print(resData);

      if (resData == null) {
        throw const ServerException();
      }
      print(resData);
      return BalanceModel.fromGraphql(map: resData);
    } on ServerException {
      throw const ServerException();
    }
  }

  @override
  Future<List<Balance>> getAllUserBalances(String walletAddress) async {
    print("QUERY USER WALLET :: $walletAddress");
    try {
      QueryResult result = await graphQLClient.query(QueryOptions(
        fetchPolicy: FetchPolicy.noCache,
        document: getUserBalanceDocument(),
        variables: {'walletAddress': walletAddress},
      ));

      print(result);

      if (result.hasException) {
        print(result.exception);
        throw const ServerException();
      }

      List? resData = [];
      resData = result.data?['getAllWalletBalances'];

      print(resData);

      if (resData == null) {
        throw const ServerException();
      }

      print(resData);

      List<Balance> balances =
          resData.map((e) => BalanceModel.fromGraphql(map: e)).toList();

      return balances;
    } on ServerException {
      throw const ServerException();
    }
  }
}
