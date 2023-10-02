import 'package:crypto_portfolio_test/core/constant/router.dart';
import 'package:crypto_portfolio_test/domain/entities/coins.dart';
import 'package:crypto_portfolio_test/domain/entities/swap.dart';
import 'package:crypto_portfolio_test/presentation/bloc/balances/get_swap_balance_bloc.dart'
    as getswap;
import 'package:crypto_portfolio_test/presentation/bloc/balances/make_swap_balance_bloc.dart'
    as makeswap;
import 'package:crypto_portfolio_test/presentation/bloc/coin/all_coins_bloc.dart';
import 'package:crypto_portfolio_test/presentation/widgets/LoadingDataWidget.dart';
import 'package:crypto_portfolio_test/presentation/widgets/SwapContainerWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SwapPage extends StatefulWidget {
  final String title;
  const SwapPage({super.key, required this.title});

  @override
  _SwapPage createState() => _SwapPage();
}

class _SwapPage extends State<SwapPage> {
  late SwapBalance? selectedSendCoin;
  late Coin? selectedGetCoin;
  final String userWalletAddress = '0xa37100bb05271853766af8ed7a32ca20c8311acc';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      selectedSendCoin = null;
      selectedGetCoin = null;
    });
    BlocProvider.of<AllCoinBloc>(context).add(LoadAllCoins());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black54,
        foregroundColor: Colors.white54,
        toolbarHeight: 65,
        titleSpacing: 10,
        title: Text(widget.title),
        actions: [
          IconButton(
              onPressed: () {}, icon: const Icon(Icons.settings_outlined))
        ],
        leading: IconButton(
            onPressed: () => context.goNamed(dashboardRouteName),
            icon: const Icon(Icons.arrow_back)),
      ),
      body: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Padding(
          padding: const EdgeInsets.all(18),
          child: Column(children: [
            const SizedBox(
              height: 10,
            ),
            BlocBuilder<getswap.GetSwapBalanceBloc,
                getswap.GetSwapBalanceState>(
              builder: (context, state) {
                if (state is getswap.Empty) {
                  // Only add the event when the state is Empty
                  BlocProvider.of<getswap.GetSwapBalanceBloc>(context).add(
                    getswap.SwapBalances(
                      walletAddress: userWalletAddress,
                    ),
                  );
                }
                return switch (state) {
                  getswap.Empty() => Placeholder(),
                  getswap.Loading() => LoadingData(),
                  getswap.Loaded() => SwapContainer(
                      title: 'You Send',
                      avatar: CircleAvatar(
                        child: Text(selectedSendCoin == null
                            ? '-'
                            : selectedSendCoin!.symbol[0]),
                      ),
                      coinPrice: selectedSendCoin == null
                          ? 0
                          : selectedSendCoin!.value,
                      dropdownWidget: DropdownButtonFormField<String>(
                        decoration: const InputDecoration(labelText: 'symbol'),
                        value: selectedSendCoin?.symbol,
                        items: state.swapBalance.balances
                            .map((SwapBalance balances) {
                          return DropdownMenuItem<String>(
                            value: balances.symbol,
                            child: Text(
                              balances.symbol,
                              style: const TextStyle(color: Colors.white70),
                            ),
                          );
                        }).toList(),
                        onChanged: (newValue) {
                          setState(() {
                            selectedSendCoin = state.swapBalance.balances
                                .firstWhere(
                                    (element) => element.symbol == newValue!);
                          });
                        },
                      ),
                      availableCoins: selectedSendCoin == null
                          ? 0
                          : selectedSendCoin!.balance,
                    ),
                  // TODO: Handle this case.
                  getswap.Error() => Text("error"),
                };
              },
            ),
            SizedBox(
              height: 10,
            ),
            BlocBuilder<AllCoinBloc, AllCoinState>(builder: (context, state) {
              return switch (state) {
                Empty() => LoadingData(),
                Loading() => LoadingData(),
                Loaded() => Column(
                    children: [
                      SwapContainer(
                        title: 'You Get',
                        dropdownWidget: DropdownButtonFormField<String>(
                          decoration:
                              const InputDecoration(labelText: 'Symbol'),
                          value: selectedGetCoin?.symbol,
                          items: state.coinList.map((Coin coin) {
                            return DropdownMenuItem<String>(
                                value: coin.symbol,
                                child: Text(
                                  coin.symbol,
                                  style: const TextStyle(color: Colors.white70),
                                ));
                          }).toList(),
                          onChanged: (newValue) {
                            setState(() {
                              selectedGetCoin = state.coinList.firstWhere(
                                  (element) => element.symbol == newValue);
                            });
                          },
                        ),
                        availableCoins:
                            selectedSendCoin == null || selectedGetCoin == null
                                ? 0
                                : (selectedSendCoin!.value /
                                    selectedGetCoin!.price),
                        avatar: CircleAvatar(
                          child: Text(selectedGetCoin == null
                              ? '-'
                              : selectedGetCoin!.symbol[0]),
                        ),
                        coinPrice: selectedGetCoin == null
                            ? 0
                            : selectedGetCoin!.price,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),

                // TODO: Handle this case.
                Error() => Placeholder(),
              };
            }),
          ]),
        ),
      ])),
      floatingActionButton: SizedBox(
          width: MediaQuery.of(context).size.width - 36,
          child: FloatingActionButton.extended(
            onPressed: () {
              BlocProvider.of<makeswap.MakeSwapBalanceBloc>(context).add(
                  makeswap.SwapBalances(
                      walletAddress: userWalletAddress,
                      sendCoinSymbol: selectedSendCoin!.symbol,
                      sendCoinPrice: selectedSendCoin!.coinPriceInDollar,
                      getCoinSymbol: selectedGetCoin!.symbol,
                      sendCoinAmount: selectedSendCoin!.balance,
                      getCoinPrice: selectedGetCoin!.price));
            },
            elevation: 0,
            isExtended: true,
            foregroundColor: Colors.white,
            backgroundColor: Colors.blue,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            label: const Row(children: [
              Text(
                'Confirm',
                style: TextStyle(fontSize: 20),
              ),
            ]),
          )),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
