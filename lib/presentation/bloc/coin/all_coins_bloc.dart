import 'dart:math';

import 'package:crypto_portfolio_test/domain/entities/coins.dart';
import 'package:crypto_portfolio_test/domain/service/service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/service/get_all_coins_service.dart';

part 'all_coins_event.dart';
part 'all_coins_state.dart';

class AllCoinBloc extends Bloc<AllCoinEvent, AllCoinState> {
  final GetAllCoinsService getAllCoinsService;
  final random = Random();
  String randomCoinValueChangeNumber() =>
      (-10 + random.nextDouble() * 20).toStringAsFixed(2);

  AllCoinBloc({required this.getAllCoinsService}) : super(Empty()) {
    on<LoadAllCoins>((event, emit) async {
      emit(Loading());
      final coinList = await getAllCoinsService.call(NoParams());
      coinList.fold((l) async => emit(Error(message: l.toString())), (r) async {
        if (r.isEmpty) {
          return emit(Empty());
        }

        final modifiedData = r.map((e) {
          final randomChange = randomCoinValueChangeNumber();
          if (randomChange[0] == '-') {
            e.change = '↓ $randomChange';
          } else {
            e.change = '↑ +$randomChange';
          }
          return e;
        }).toList();

        return emit(Loaded(coinList: modifiedData));
      });
    });
  }
}
