import 'package:crypto_portfolio_test/presentation/bloc/coin/coin_bloc.dart';
import 'package:crypto_portfolio_test/presentation/widgets/LoadingDataWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateCoinPage extends StatefulWidget {
  const CreateCoinPage({super.key});

  @override
  _CreateCoinPage createState() => _CreateCoinPage();
}

class _CreateCoinPage extends State<CreateCoinPage> {
  final TextEditingController symbolController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: BlocBuilder<CoinBloc, CoinState>(
        builder: (context, state) {
          switch (state) {
            case Loaded():
              {
                symbolController.text = '';
                priceController.text = '';
              }
            case Empty():
              {
                symbolController.text = '';
                priceController.text = '';
              }
            case Error():
            // TODO: Add a notification.
            default:
              null;
          }
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextField(
                  controller: symbolController,
                  decoration: const InputDecoration(
                      labelText: 'Symbol',
                      filled: true,
                      fillColor: Colors.white10),
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(4),
                    FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z]')),
                  ],
                  style: const TextStyle(color: Colors.white),
                  onChanged: (text) {
                    symbolController.text =
                        text.toUpperCase(); // Convert to uppercase
                    symbolController.selection = TextSelection.fromPosition(
                        TextPosition(offset: symbolController.text.length));
                  },
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: priceController,
                  decoration: const InputDecoration(
                      labelText: 'Price',
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
                      return 'Please enter a price';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24.0),
                ElevatedButton(
                    onPressed: () {
                      BlocProvider.of<CoinBloc>(context).add(CreateACoin(
                          symbol: symbolController.text,
                          price: priceController.text));
                    },
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.resolveWith<Color?>(
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
                      foregroundColor:
                          MaterialStateProperty.resolveWith<Color?>(
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
                          borderRadius:
                              BorderRadius.circular(10.0), // Custom shape
                        ),
                      ),
                    ),
                    child: state == Loading()
                        ? LoadingData()
                        : Text("Create Coin")),
              ],
            ),
          );
        },
      ),
    );
  }
}
