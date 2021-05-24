import 'package:dartz/dartz.dart';

import '../../../core/failure.dart';
import '../repositories/auth_repository.dart';

class SignupUsecase {
  final AuthRepository authRepo;
  SignupUsecase(this.authRepo);

  Future<Either<Failure, void>> call(String username, String password) =>
      authRepo.signup(username, password);
}
