import 'package:dartz/dartz.dart';

import '../../../core/failure.dart';
import '../repositories/auth_repository.dart';

class LoginUsecase {
  final AuthRepository authRepo;
  LoginUsecase(this.authRepo);
  Future<Either<Failure, void>> call(String username, String password) =>
      authRepo.login(username, password);
}
