import 'package:crypto_portfolio_test/core/errors/failures.dart';
import 'package:crypto_portfolio_test/data/apidef/create_or_update_user_api.dart';
import 'package:crypto_portfolio_test/data/apidef/get_all_coins_api.dart';
import 'package:crypto_portfolio_test/data/apidef/get_user_api.dart';
import 'package:crypto_portfolio_test/data/models/coin.dart';
import 'package:crypto_portfolio_test/data/models/user.dart';
import 'package:crypto_portfolio_test/domain/entities/auth_user.dart';
import 'package:crypto_portfolio_test/domain/entities/coins.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

abstract class UserRemoteDataSource {
  Future<AuthUser> getUser(String username);
  Future<AuthUser> createOrUpdateUser(String username, String walletAddress);
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final GraphQLClient graphQLClient;
  UserRemoteDataSourceImpl({
    required this.graphQLClient,
  });

  @override
  Future<AuthUser> getUser(String username) async {
    try{
      QueryResult result = await graphQLClient.query(QueryOptions(
          fetchPolicy: FetchPolicy.noCache,
          document: getUserApiDocument(),
          variables: {'_username' : username}
      ));

      if(result.hasException) {
        throw const ServerException();
      }


      final resData = result.data?['getUserByUserName'];

      if(resData == null || resData.isEmpty) {
        throw const ServerException();
      }

      AuthUser authUser = AuthModel.fromGraphql(map: resData);
      return authUser;
    } on ServerException {
      throw const ServerException();
    }
  }

  @override
  Future<AuthUser> createOrUpdateUser(String username, String walletAddress) async {
    try{
      QueryResult result = await graphQLClient.mutate(MutationOptions(
          fetchPolicy: FetchPolicy.noCache,
          document: createOrUpdateUserApiDocument(),
          variables: {'_username' : username, '_walletAddress' : walletAddress}
      ));

      if(result.hasException) {
        throw const ServerException();
      }


      final resData = result.data?['upsertUser'];

      if(resData == null || resData.isEmpty) {
        throw const ServerException();
      }

      AuthUser authUser = AuthModel.fromGraphql(map: resData);
      return authUser;
    } on ServerException {
      throw const ServerException();
    }
  }

}
