import 'package:crypto_portfolio_test/domain/entities/auth_user.dart';
import 'package:crypto_portfolio_test/domain/entities/coins.dart';

class AuthModel extends AuthUser {
  const AuthModel({required super.username, required super.walletAddress});

  static AuthModel fromGraphql({required Map<String, dynamic> map}) => AuthModel(
      username: map['username'],
      walletAddress: map['walletAddress'],
  );

  factory AuthModel.fromJSON(Map<String, dynamic> json) {
    return AuthModel(
      username: json['username'],
      walletAddress: json['walletAddress'],
    );
  }

  Map<String, dynamic> toJSON() {
    return {
      'username' : username,
      'walletAddress'  : walletAddress,
    };
  }
}