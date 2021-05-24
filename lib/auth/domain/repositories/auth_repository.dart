import 'package:dartz/dartz.dart';

import '../../../core/failure.dart';

abstract class AuthRepository {
  Future<Either<Failure, void>> login(String username, String password);

  Future<Either<Failure, void>> signup(String username, String password);

  Future<Either<Failure, void>> autoLogin();

  Future<Either<Failure,void>> logout();
}
