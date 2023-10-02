import 'package:crypto_portfolio_test/domain/entities/auth_user.dart';
import 'package:crypto_portfolio_test/core/errors/failures.dart';
import 'package:dartz/dartz.dart';

abstract class AuthRepository {
  Future<Either<Failure, AuthUser>> loginUser();
  Future<Either<Failure, bool>> logoutUser();
}