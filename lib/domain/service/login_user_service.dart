import 'package:crypto_portfolio_test/domain/entities/auth_user.dart';
import 'package:crypto_portfolio_test/domain/repositories/auth_repository.dart';
import 'package:crypto_portfolio_test/domain/service/service.dart';
import 'package:crypto_portfolio_test/core/errors/failures.dart';
import 'package:dartz/dartz.dart';

class LoginUserService implements Service<AuthUser, NoParams> {
  final AuthRepository repository;

  LoginUserService(this.repository);

  @override
  Future<Either<Failure, AuthUser>> call(NoParams params) async {
    return await repository.loginUser();
  }
}