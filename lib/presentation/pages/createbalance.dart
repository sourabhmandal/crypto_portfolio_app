import 'package:crypto_portfolio_test/core/constant/router.dart';
import 'package:crypto_portfolio_test/presentation/bloc/balances/create_user_balance_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';

class CreateBalancePage extends StatefulWidget {
  final String title;
  const CreateBalancePage({super.key, required this.title});

  @override
  _CreateCoinPage createState() => _CreateCoinPage();
}

class _CreateCoinPage extends State<CreateBalancePage> {
  final TextEditingController symbolController = TextEditingController();
  final TextEditingController balanceController = TextEditingController();
  final TextEditingController walletController = TextEditingController();
  final List<String> _currencies = [
    "Food",
    "Transport",
    "Personal",
    "Shopping",
    "Medical",
    "Rent",
    "Movie",
    "Salary"
  ];
  String _selectedValue = 'Food';

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
      body: SingleChildScrollView(child: buildBody(context)),
      floatingActionButton: SizedBox(
          width: MediaQuery.of(context).size.width - 36,
          child: FloatingActionButton.extended(
            onPressed: () {
              BlocProvider.of<CreateUserBalanceBloc>(context)
                  .add(CreateUserBalance(
                symbol: symbolController.text,
                balance: double.parse(
                    double.parse(balanceController.text).toStringAsFixed(2)),
                walletAddress: walletController.text,
              ));
            },
            elevation: 0,
            isExtended: true,
            foregroundColor: Colors.white,
            backgroundColor: Colors.blue,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            label: const Row(children: [
              Text(
                'Create Coin',
                style: TextStyle(fontSize: 20),
              ),
            ]),
          )),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget buildBody(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: BlocBuilder<CreateUserBalanceBloc, CreateUserBalanceState>(
        builder: (context, state) {
          switch (state) {
            case Loaded():
              {
                symbolController.text = '';
                balanceController.text = '';
                walletController.text = '';
              }
            case Error():
              Fluttertoast.showToast(
                msg: state.message,
                toastLength: Toast
                    .LENGTH_SHORT, // Duration for which the toast will be visible (Toast.LENGTH_SHORT or Toast.LENGTH_LONG)
                gravity: ToastGravity
                    .TOP, // Location where the toast will appear on the screen (e.g., ToastGravity.TOP, ToastGravity.CENTER)
                timeInSecForIosWeb:
                    1, // Duration for which the toast will be visible on iOS and web platforms
                backgroundColor: Colors.grey, // Background color of the toast
                textColor: Colors.white, // Text color of the toast message
                fontSize: 16.0, // Font size of the toast message
              );
            default:
              null;
          }
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(labelText: 'Coin Symbol'),
                  value: symbolController.text,
                  items: _currencies.map((String option) {
                    return DropdownMenuItem<String>(
                      value: option,
                      child:
                          Text(option, style: TextStyle(color: Colors.white70)),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      symbolController.text = newValue!;
                    });
                  },
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: balanceController,
                  decoration: const InputDecoration(
                      labelText: 'Balance',
                      filled: true,
                      fillColor: Colors.white10),
                  style: const TextStyle(color: Colors.white),
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(10),
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
                  ],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter amount of coin available';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: walletController,
                  decoration: const InputDecoration(
                      labelText: 'Wallet Address',
                      filled: true,
                      fillColor: Colors.white10),
                  style: const TextStyle(color: Colors.white),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter amount of coin available';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24.0),
              ],
            ),
          );
        },
      ),
    );
  }
}
