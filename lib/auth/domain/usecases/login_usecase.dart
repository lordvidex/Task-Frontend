import 'package:dartz/dartz.dart';
import 'package:taskmanagement_frontend/auth/data/repositories/auth_repository.dart';
import 'package:taskmanagement_frontend/core/failure.dart';

class LoginUseCase {
  final AuthRepository authRepo;
  LoginUseCase(this.authRepo);
  Future<Either<Failure, void>> call(String username, String password) =>
      authRepo.login(username, password);
}
