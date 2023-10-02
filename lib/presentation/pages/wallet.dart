import 'package:crypto_portfolio_test/core/constant/router.dart';
import 'package:crypto_portfolio_test/presentation/widgets/CoinListItemWidget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class WalletPage extends StatelessWidget {
  const WalletPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 18),
      child: SingleChildScrollView(
        child: Column(
          children: [
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith<Color?>(
                  (Set<MaterialState> states) {
                    if (states.contains(MaterialState.pressed)) {
                      return Theme.of(context)
                          .colorScheme
                          .secondary
                          .withOpacity(0.3);
                    }
                    return Theme.of(context)
                        .colorScheme
                        .primary
                        .withOpacity(0.8);
                  },
                ),
                foregroundColor: MaterialStateProperty.resolveWith<Color?>(
                  (Set<MaterialState> states) {
                    if (states.contains(MaterialState.pressed)) {
                      return Theme.of(context)
                          .colorScheme
                          .inversePrimary
                          .withOpacity(0.3);
                    }
                    return Theme.of(context)
                        .colorScheme
                        .inversePrimary
                        .withOpacity(0.8);
                  },
                ),
                minimumSize: MaterialStateProperty.all<Size>(
                    const Size(200.0, 50.0)), // Button size
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0), // Custom shape
                  ),
                ),
              ),
              onPressed: () {
                context.go(createUserBalanceRouteName);
              },
              child: const Text("Add balance"),
            ),
            SizedBox(
              height: 10,
            ),
            CoinListItem(
                symbol: 'SBA',
                price: 567,
                subtext: Text(
                  "\$22.9",
                  style: TextStyle(color: Colors.white54),
                ))
          ],
        ),
      ),
    );
  }
}
