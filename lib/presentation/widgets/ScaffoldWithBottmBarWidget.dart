import 'package:crypto_portfolio_test/core/constant/router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ScaffoldWithBottmBar extends StatelessWidget {
  final Widget child;
  final String username;
  const ScaffoldWithBottmBar(
      {super.key, required this.child, required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black54,
        foregroundColor: Colors.white54,
        toolbarHeight: 65,
        titleSpacing: 10,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
                padding: const EdgeInsetsDirectional.only(bottom: 3),
                child: Text(
                  "Hi! ${username}",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.white54),
                )),
            const Text(
              "Welcome",
              style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 14,
                  color: Colors.white54),
            ),
          ],
        ),
        actions: [
          IconButton(
              onPressed: () {}, icon: const Icon(Icons.settings_outlined))
        ],
        leading: Padding(
            padding: EdgeInsets.all(8),
            child: CircleAvatar(
              backgroundColor: Colors.orange,
              child: Text(username.toUpperCase()[0]),
            )),
      ),
      body: child,
      floatingActionButton: SizedBox(
          width: 80,
          height: 80,
          child: FloatingActionButton(
              onPressed: () => context.goNamed(swapRouteName),
              backgroundColor: Colors.blueGrey,
              foregroundColor: Colors.white,
              tooltip: 'Swap Coins',
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(50.0))),
              child: const Icon(
                Icons.currency_exchange_rounded,
                size: 40,
              ))),
      bottomNavigationBar: BottomAppBar(
        color: Colors.blue,
        shape: const CircularNotchedRectangle(),
        child: Row(
          children: <Widget>[
            Expanded(
                child: IconButton(
              tooltip: 'Open navigation menu',
              icon: const Icon(
                Icons.dashboard_rounded,
                color: Colors.white60,
              ),
              onPressed: () => context.goNamed(dashboardRouteName),
            )),
            Expanded(
                child: IconButton(
              tooltip: 'Show wallet balances',
              icon: const Icon(
                Icons.wallet_rounded,
                color: Colors.white60,
              ),
              onPressed: () => context.goNamed(walletRouteName),
            )),
            SizedBox(
              width: 100,
            ),
            Expanded(
              child: IconButton(
                tooltip: 'Wallet balances',
                icon: const Icon(
                  Icons.control_point_duplicate_rounded,
                  color: Colors.white60,
                ),
                onPressed: () {
                  context.goNamed(createCoinRouteName);
                },
              ),
            ),
            Expanded(
                child: IconButton(
              tooltip: 'user account',
              icon: const Icon(
                Icons.person_2_rounded,
                color: Colors.white60,
              ),
              onPressed: () {},
            )),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
