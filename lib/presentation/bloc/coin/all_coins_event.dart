part of 'all_coins_bloc.dart';

sealed class AllCoinEvent extends Equatable {
  const AllCoinEvent();

  @override
  List<Object> get props => [];
}

class LoadAllCoins extends AllCoinEvent {}
