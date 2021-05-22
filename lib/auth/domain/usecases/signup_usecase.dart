import 'package:dartz/dartz.dart';

import '../../../core/failure.dart';
import '../../data/repositories/auth_repository.dart';

class SignupUseCase {
  final AuthRepository authRepo;
  SignupUseCase(this.authRepo);

  Future<Either<Failure, void>> call(String username, String password) =>
      authRepo.signup(username, password);
}
