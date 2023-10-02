import 'dart:convert';

import 'package:crypto_portfolio_test/core/constant/strings.dart';
import 'package:crypto_portfolio_test/core/errors/exceptions.dart';
import 'package:crypto_portfolio_test/data/models/coin.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class CoinLocalDataSource {
  Future<List<CoinModel>> getLastAllCoin();
  Future<void> cacheAllCoin(List<CoinModel> coins);
}

class CoinLocalDataSourceImpl implements CoinLocalDataSource {
  final SharedPreferences sharedPreferences;

  CoinLocalDataSourceImpl({
    required this.sharedPreferences
  });

  @override
  Future<List<CoinModel>> getLastAllCoin() {
    final jsonStringList = sharedPreferences.getStringList(cachedCoinData);

    if (jsonStringList == null) {
      throw CacheException();
    }
    return Future.value(jsonStringList.map(
            (jsonData) => CoinModel.fromJSON(json.decode(jsonData))).toList());
  }

  @override
  Future<void> cacheAllCoin(List<CoinModel> coins) async {
    final List<String> jsonList = coins.map((model) => model.toJSON().toString()).toList();
    await sharedPreferences.setStringList(cachedCoinData, jsonList);
  }
}