import 'package:crypto_portfolio_test/domain/entities/auth_user.dart';
import 'package:crypto_portfolio_test/domain/entities/coins.dart';
import 'package:crypto_portfolio_test/domain/repositories/auth_repository.dart';
import 'package:crypto_portfolio_test/domain/service/service.dart';
import 'package:crypto_portfolio_test/core/errors/failures.dart';
import 'package:dartz/dartz.dart';

class LogoutUserService implements Service<bool, NoParams> {
  final AuthRepository repository;

  LogoutUserService(this.repository);

  @override
  Future<Either<Failure, bool>> call(NoParams params) async {
    return await repository.logoutUser();
  }
}