import 'dart:ffi';

import 'package:equatable/equatable.dart';
import 'package:web3auth_flutter/output.dart';

class AuthUser extends Equatable {
  final String username, walletAddress;
  final String? privKey;

  const AuthUser({
    required this.username,
    required this.walletAddress,
    this.privKey,
  });

  @override
  List<Object> get props => [username, walletAddress];
}