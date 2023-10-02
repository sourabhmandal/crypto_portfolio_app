import 'package:crypto_portfolio_test/core/constant/market_data.dart';
import 'package:crypto_portfolio_test/presentation/bloc/coin/all_coins_bloc.dart';
import 'package:crypto_portfolio_test/presentation/widgets/CapitailizationWidget.dart';
import 'package:crypto_portfolio_test/presentation/widgets/CoinListItemWidget.dart';
import 'package:crypto_portfolio_test/presentation/widgets/LoadingDataWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardPage extends StatefulWidget {
  final String username;
  const DashboardPage({super.key, required this.username});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<AllCoinBloc>(context).add(LoadAllCoins());
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(18),
            child: Text(
              "Markets",
              style: TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.w700,
                  color: Colors.white54),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          BlocBuilder<AllCoinBloc, AllCoinState>(
            builder: (context, state) {
              return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: Column(
                    children: [
                      Row(children: [
                        Expanded(
                            child: CapitalizationWidget(
                          backgroundColor: Colors.greenAccent,
                          title: 'Total M. Cap',
                          titleColor: Colors.blueGrey,
                          bodyColor: Colors.black87,
                          marketCap: 2.25,
                          pillData: '+3.36%',
                          pillBackgroundColor: Colors.greenAccent[700],
                          data: marketCapData,
                        )),
                        SizedBox(width: 8),
                        Expanded(
                            child: CapitalizationWidget(
                          backgroundColor: Colors.deepPurple[600],
                          title: 'Defi Cap',
                          titleColor: Colors.white60,
                          bodyColor: Colors.white70,
                          marketCap: 38.7,
                          pillData: '-7.54%',
                          pillBackgroundColor: Colors.deepPurple[800],
                          data: defiData,
                        )),
                      ]),
                      const Padding(
                          padding: EdgeInsets.symmetric(vertical: 18),
                          child: Row(
                            children: [
                              Padding(
                                  padding: EdgeInsets.all(8),
                                  child: Icon(
                                    Icons.auto_graph_outlined,
                                    color: Colors.white70,
                                  )),
                              Text('Top Gainers',
                                  style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: 26,
                                      fontWeight: FontWeight.bold)),
                            ],
                          )),
                      switch (state) {
                        Empty() => const Column(
                            children: [
                              Text("No Data Present",
                                  style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold))
                            ],
                          ),
                        Loading() => const LoadingData(),
                        Loaded() => Column(
                            children: state.coinList.map((e) {
                              return CoinListItem(
                                symbol: e.symbol,
                                price: e.price,
                                subtext: Text(
                                  e.change,
                                  style: TextStyle(
                                      color: e.change[0] == '↑'
                                          ? Colors.green[400]
                                          : Colors.red,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                              );
                            }).toList(),
                          ),
                        Error() => Column(
                            children: [
                              Text(state.message,
                                  style: const TextStyle(
                                      color: Colors.white70,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                      }
                    ],
                  ));
            },
          ),
        ],
      ),
    );
  }
}
