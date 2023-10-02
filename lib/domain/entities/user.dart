import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String username;
  final String walletAddress;

  const User({required this.username, required this.walletAddress});

  @override
  List<Object> get props => [username, walletAddress];
}
