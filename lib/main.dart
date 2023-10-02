import 'package:crypto_portfolio_test/presentation/injection_container.dart' as di;
import 'package:crypto_portfolio_test/presentation/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensure Flutter is initialized
  GoRouter.optionURLReflectsImperativeAPIs = true;
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: AppRouter(loginState: true).router,
      title: 'Crypto Portfolio',
      theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple)
              .copyWith(background: Colors.black54),
          appBarTheme: const AppBarTheme(
            foregroundColor: Colors.blueGrey,
          )
      ),
    );

  }
}