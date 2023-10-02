import 'package:crypto_portfolio_test/core/constant/router.dart';
import 'package:crypto_portfolio_test/presentation/bloc/balances/create_user_balance_bloc.dart';
import 'package:crypto_portfolio_test/presentation/bloc/balances/get_swap_balance_bloc.dart';
import 'package:crypto_portfolio_test/presentation/bloc/balances/make_swap_balance_bloc.dart';
import 'package:crypto_portfolio_test/presentation/bloc/coin/all_coins_bloc.dart';
import 'package:crypto_portfolio_test/presentation/bloc/coin/coin_bloc.dart';
import 'package:crypto_portfolio_test/presentation/injection_container.dart'
    as di;
import 'package:crypto_portfolio_test/presentation/pages/callback.dart';
import 'package:crypto_portfolio_test/presentation/pages/createbalance.dart';
import 'package:crypto_portfolio_test/presentation/pages/createcoin.dart';
import 'package:crypto_portfolio_test/presentation/pages/dashboard.dart';
import 'package:crypto_portfolio_test/presentation/pages/error.dart';
import 'package:crypto_portfolio_test/presentation/pages/login.dart';
import 'package:crypto_portfolio_test/presentation/pages/swap.dart';
import 'package:crypto_portfolio_test/presentation/pages/wallet.dart';
import 'package:crypto_portfolio_test/presentation/widgets/ScaffoldWithBottmBarWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  final bool loginState;
  AppRouter({required this.loginState});

  final GlobalKey<NavigatorState> _rootNavigatorKey =
      GlobalKey<NavigatorState>();

  final GlobalKey<NavigatorState> _bottomBarNavKey =
      GlobalKey<NavigatorState>();

  late GoRouter router = GoRouter(
    // refreshListenable: loginState,
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/$swapRouteName', // '/$dashboardRouteName',
    debugLogDiagnostics: true,
    routes: [
      ShellRoute(
          builder: (context, state, child) {
            return ScaffoldWithBottmBar(
              username: "Anna",
              child: child,
            );
          },
          routes: <RouteBase>[
            GoRoute(
              name: dashboardRouteName,
              path: '/$dashboardRouteName',
              builder: (context, state) => BlocProvider(
                create: (_) => di.sl<AllCoinBloc>(),
                child: const DashboardPage(username: "Anna"),
              ),
            ),
            GoRoute(
              name: createCoinRouteName,
              path: '/$createCoinRouteName',
              builder: (context, state) => BlocProvider(
                create: (_) => di.sl<CoinBloc>(),
                child: const CreateCoinPage(),
              ),
            ),
            GoRoute(
              name: walletRouteName,
              path: '/$walletRouteName',
              builder: (context, state) => BlocProvider(
                create: (_) => di.sl<CoinBloc>(),
                child: const WalletPage(),
              ),
            ),
          ]),
      GoRoute(
        name: swapRouteName,
        path: '/$swapRouteName',
        builder: (context, state) => MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => di.sl<MakeSwapBalanceBloc>()),
            BlocProvider(create: (_) => di.sl<GetSwapBalanceBloc>()),
            BlocProvider(create: (_) => di.sl<AllCoinBloc>()),
          ],
          child: const SwapPage(title: 'Swap'),
        ),
      ),
      GoRoute(
        name: createUserBalanceRouteName,
        path: '/$createUserBalanceRouteName',
        builder: (context, state) => BlocProvider(
          create: (_) => di.sl<CreateUserBalanceBloc>(),
          child: const CreateBalancePage(title: 'Add Balance'),
        ),
      ),
      GoRoute(
        name: loginRouteName,
        path: '/$loginRouteName',
        builder: (context, state) => BlocProvider(
          create: (_) => di.sl<AllCoinBloc>(),
          child: const LoginPage(),
        ),
      ),
      GoRoute(
        name: callbackRouteName,
        path: '/$callbackRouteName',
        builder: (context, state) => const CallbackPage(),
      ),
      GoRoute(
        name: rootRouteName,
        path: '/',
        redirect: (context, state) =>
            // TODO: Change to Home Route
            state.namedLocation(loginRouteName),
      ),
    ],
    errorBuilder: (context, state) => ErrorPage(error: state.error!.message),
    redirect: (context, state) {
      // final isLoggedIn = authRepository.currentUser != null;
      // final path = state.uri.path;
      // // redirect to '/' if the user is signed in and the path is '/signIn'
      // if (isLoggedIn) {
      //   if (path == '/signIn') {
      //     return '/';
      //   }
      // }
      return null;
    },
  );
}
