import 'package:flutter/material.dart';

class CoinListItem extends StatelessWidget {
  late final String _symbol;
  late final String _price;
  late final Widget _subtext;

  CoinListItem(
      {Key? key,
      required String symbol,
      required double price,
      required Widget subtext})
      : super(key: key) {
    _symbol = symbol.toUpperCase();
    _price = '\$$price';
    _subtext = subtext;
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(width: 1, color: Colors.blueGrey),
          ),
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.blueGrey,
                  key: key,
                  child: Text(_symbol[0]),
                ),
                Expanded(
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _symbol,
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                              Text(
                                _symbol,
                                style: const TextStyle(
                                    color: Colors.white70, fontSize: 14),
                              )
                            ],
                          ))),
                ),
                Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              _price,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 20),
                            ),
                            _subtext,
                          ],
                        ))),
              ],
            ),
          )),
      const SizedBox(
        height: 10,
      ),
    ]);
  }
}
