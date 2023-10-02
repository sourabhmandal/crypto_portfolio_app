import 'package:crypto_portfolio_test/core/constant/strings.dart';
import 'package:crypto_portfolio_test/core/network/network_info.dart';
import 'package:crypto_portfolio_test/core/presentation/input_convertor.dart';
import 'package:crypto_portfolio_test/data/datasources/balance_remote_data_source.dart';
import 'package:crypto_portfolio_test/data/datasources/coin_local_data_source.dart';
import 'package:crypto_portfolio_test/data/datasources/coin_remote_data_source.dart';
import 'package:crypto_portfolio_test/data/repositories/balance_repository_impl.dart';
import 'package:crypto_portfolio_test/data/repositories/coin_repository_impl.dart';
import 'package:crypto_portfolio_test/domain/repositories/balance_repository.dart';
import 'package:crypto_portfolio_test/domain/repositories/coin_repository.dart';
import 'package:crypto_portfolio_test/domain/service/create_coin_service.dart';
import 'package:crypto_portfolio_test/domain/service/create_user_balance_service.dart';
import 'package:crypto_portfolio_test/domain/service/get_all_coins_service.dart';
import 'package:crypto_portfolio_test/domain/service/get_swap_service.dart';
import 'package:crypto_portfolio_test/domain/service/get_user_balances_service.dart';
import 'package:crypto_portfolio_test/domain/service/make_swap_service.dart';
import 'package:crypto_portfolio_test/presentation/bloc/balances/create_user_balance_bloc.dart';
import 'package:crypto_portfolio_test/presentation/bloc/balances/get_all_user_balances_bloc.dart';
import 'package:crypto_portfolio_test/presentation/bloc/balances/get_swap_balance_bloc.dart';
import 'package:crypto_portfolio_test/presentation/bloc/balances/make_swap_balance_bloc.dart';
import 'package:crypto_portfolio_test/presentation/bloc/coin/all_coins_bloc.dart';
import 'package:crypto_portfolio_test/presentation/bloc/coin/coin_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web3auth_flutter/enums.dart';
import 'package:web3auth_flutter/input.dart';
import 'package:web3auth_flutter/web3auth_flutter.dart';

final sl = GetIt.instance;

Future<void> init() async {
  await Web3AuthFlutter.init(Web3AuthOptions(
    clientId: web3AuthClientId,
    network: Network.testnet,
    redirectUrl: Uri.parse(callbackUrl),
  ));

  // features
  sl.registerLazySingleton(() => GetAllCoinsService(sl()));
  sl.registerLazySingleton(() => CreateCoinService(sl()));
  sl.registerLazySingleton(() => CreateUserBalanceService(sl()));
  sl.registerLazySingleton(() => GetUserBalanceService(sl()));
  sl.registerLazySingleton(
      () => GetSwapService(balanceRepository: sl(), coinRepository: sl()));
  sl.registerLazySingleton(
      () => MakeSwapService(coinRepository: sl(), balanceRepository: sl()));

  sl.registerLazySingleton<CoinRepository>(() => CoinRepositoryImpl(
      remoteDataSource: sl(), localDataSource: sl(), networkInfo: sl()));
  sl.registerLazySingleton<BalanceRepository>(
      () => BalanceRepositoryImpl(networkInfo: sl(), remoteDataSource: sl()));

  sl.registerLazySingleton<CoinRemoteDataSource>(
      () => CoinRemoteDataSourceImpl(graphQLClient: sl()));
  sl.registerLazySingleton<CoinLocalDataSource>(
      () => CoinLocalDataSourceImpl(sharedPreferences: sl()));
  sl.registerLazySingleton<BalanceRemoteDataSource>(
      () => BalanceRemoteDataSourceImpl(graphQLClient: sl()));

  sl.registerFactory(() => AllCoinBloc(getAllCoinsService: sl()));
  sl.registerFactory(
      () => CoinBloc(inputConverter: sl(), createCoinService: sl()));
  sl.registerFactory(
      () => CreateUserBalanceBloc(createUserBalanceService: sl()));
  sl.registerFactory(() => GetUserBalanceBloc(getUserBalanceService: sl()));
  sl.registerFactory(() => GetSwapBalanceBloc(getSwapService: sl()));
  sl.registerFactory(() => MakeSwapBalanceBloc(makeSwapService: sl()));

  // core
  sl.registerLazySingleton(() => InputConverter());
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  // external
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerFactory<GraphQLClient>(() {
    final HttpLink httpLink = HttpLink(graphQlApiBaseUrl);
    return GraphQLClient(link: httpLink, cache: GraphQLCache());
  });
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
