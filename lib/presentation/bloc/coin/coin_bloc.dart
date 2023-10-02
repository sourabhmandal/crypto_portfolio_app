import 'package:crypto_portfolio_test/domain/entities/coins.dart';
import 'package:crypto_portfolio_test/domain/service/create_coin_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/presentation/input_convertor.dart';

part 'coin_event.dart';
part 'coin_state.dart';

class CoinBloc extends Bloc<CoinEvent, CoinState> {
  final CreateCoinService createCoinService;
  final InputConverter inputConverter;

  CoinBloc({required this.inputConverter, required this.createCoinService})
      : super(Empty()) {
    on<CreateACoin>((event, emit) async {
      emit(Loading());

      final priceInDoubleORFailed =
          inputConverter.stringToUnsignedDouble(event.price);

      final priceInDouble = priceInDoubleORFailed.fold(
          (l) async => emit(Error(message: l.toString())), (r) => r);

      if (priceInDouble is double) {
        final createdCoin = await createCoinService
            .call(Params(symbol: event.symbol, price: priceInDouble));

        createdCoin.fold((l) async => emit(Error(message: l.toString())),
            (r) async {
          return emit(Loaded(createdCoin: r));
        });
      }
    });
  }
}
